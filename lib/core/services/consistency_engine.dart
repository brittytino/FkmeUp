import 'dart:convert';

import '../../data/local/progress_local_data_source.dart';
import '../../data/local/settings_local_data_source.dart';
import '../../data/local/sync_queue_local_data_source.dart';
import '../../models/daily_stats_model.dart';
import '../../models/level_model.dart';
import '../../models/settings_model.dart';
import '../../models/streak_model.dart';
import '../../models/sync_queue_item.dart';
import '../../models/task_model.dart';
import '../../utils/streak_utils.dart';
import '../../utils/level_utils.dart';
import '../constants/app_constants.dart';
import '../time/date_utils.dart';

class ConsistencyEngine {
  ConsistencyEngine({
    required ProgressLocalDataSource progressLocal,
    required SettingsLocalDataSource settingsLocal,
    required SyncQueueLocalDataSource syncQueue,
  })  : _progressLocal = progressLocal,
        _settingsLocal = settingsLocal,
        _syncQueue = syncQueue;

  final ProgressLocalDataSource _progressLocal;
  final SettingsLocalDataSource _settingsLocal;
  final SyncQueueLocalDataSource _syncQueue;

  Future<void> onTaskCompleted(TaskModel task, List<TaskModel> allTasks) async {
    await _upsertDailyStats(task);
    await _upsertLevel(allTasks);
    await _upsertStreak(allTasks);
  }

  Future<void> _upsertDailyStats(TaskModel task) async {
    final completedAt = task.completedAt;
    if (completedAt == null) {
      return;
    }

    final day = startOfDay(completedAt.toUtc());
    final now = DateTime.now().toUtc();
    final existing = await _progressLocal.getDailyStatsByDate(day);

    DailyStatsModel updated;
    if (existing == null) {
      updated = DailyStatsModel(
        userId: AppConstants.localUserId,
        date: day,
        xpEarned: task.xp,
        tasksCompleted: 1,
        updatedAt: now,
      );
    } else {
      updated = DailyStatsModel(
        userId: existing.userId,
        date: existing.date,
        xpEarned: existing.xpEarned + task.xp,
        tasksCompleted: existing.tasksCompleted + 1,
        updatedAt: now,
      )..id = existing.id;
    }

    await _progressLocal.upsertDailyStats(updated);
    await _enqueue(
      table: 'daily_stats',
      recordId: '${updated.userId}:${updated.date.toIso8601String()}',
      payload: updated.toJson(),
      updatedAt: updated.updatedAt,
    );
  }

  Future<void> _upsertLevel(List<TaskModel> tasks) async {
    final completed = tasks.where((task) => task.status == TaskStatus.completed);
    final totalXp = completed.fold<int>(0, (sum, task) => sum + task.xp).clamp(0, 2147483647);
    final progress = computeLevelProgress(totalXp);
    final now = DateTime.now().toUtc();

    final current = await _progressLocal.getLevel(AppConstants.localUserId);
    final updated = LevelModel(
      userId: AppConstants.localUserId,
      totalXp: totalXp,
      level: progress.level,
      xpToNextLevel: progress.xpToNext,
      updatedAt: now,
    );

    if (current != null) {
      updated.id = current.id;
    }

    await _progressLocal.upsertLevel(updated);
    await _enqueue(
      table: 'levels',
      recordId: updated.userId,
      payload: updated.toJson(),
      updatedAt: updated.updatedAt,
    );
  }

  Future<void> _upsertStreak(List<TaskModel> tasks) async {
    final settings = await _settingsLocal.fetch() ??
        SettingsModel(
          syncEnabled: true,
          supabaseUrl: '',
          supabaseAnonKey: '',
          graceDayEnabled: true,
          graceDaysPer30: 1,
        );

    final completedDays = tasks
        .where((task) => task.status == TaskStatus.completed && task.completedAt != null)
        .map((task) => startOfDay(task.completedAt!.toUtc()))
        .toSet();
    final streakMetrics = computeStreakMetrics(
      completedDays: completedDays,
      now: DateTime.now(),
      graceEnabled: settings.graceDayEnabled,
      graceDaysPer30: settings.graceDaysPer30,
    );
    final lastCompletion = completedDays.isEmpty
        ? null
        : completedDays.reduce((a, b) => a.isAfter(b) ? a : b);

    final currentStored = await _progressLocal.getStreak(AppConstants.localUserId);
    final updated = StreakModel(
      userId: AppConstants.localUserId,
      currentStreak: streakMetrics.current,
      longestStreak: streakMetrics.longest,
      lastCompletionDate: lastCompletion,
      graceDaysUsed: streakMetrics.graceUsed,
      updatedAt: DateTime.now().toUtc(),
    );

    if (currentStored != null) {
      updated.id = currentStored.id;
    }

    await _progressLocal.upsertStreak(updated);
    await _enqueue(
      table: 'streaks',
      recordId: updated.userId,
      payload: updated.toJson(),
      updatedAt: updated.updatedAt,
    );
  }

  Future<void> _enqueue({
    required String table,
    required String recordId,
    required Map<String, dynamic> payload,
    required DateTime updatedAt,
  }) async {
    await _syncQueue.enqueue(
      SyncQueueItem(
        table: table,
        recordId: recordId,
        operation: SyncOperation.upsert,
        payload: jsonEncode(payload),
        updatedAt: updatedAt,
      ),
    );
  }
}
