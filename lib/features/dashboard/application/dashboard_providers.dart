import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/time/date_utils.dart';
import '../../../models/settings_model.dart';
import '../../../models/task_model.dart';
import '../../../utils/streak_utils.dart';
import '../../../utils/level_utils.dart';
import '../../settings/application/settings_providers.dart';
import '../../tasks/application/task_providers.dart';

final dashboardStatsProvider = Provider<AsyncValue<DashboardStats>>((ref) {
  final tasksAsync = ref.watch(taskListProvider);
  final settingsAsync = ref.watch(settingsProvider);

  return tasksAsync.whenData((tasks) {
    final settings = settingsAsync.value ?? defaultSettings();
    return DashboardStats.fromTasks(tasks, settings);
  });
});

class DashboardStats {
  DashboardStats({
    required this.totalXp,
    required this.currentLevel,
    required this.xpToNextLevel,
    required this.xpIntoLevel,
    required this.currentStreak,
    required this.longestStreak,
    required this.tasksToday,
    required this.tasksWeek,
    required this.tasksTotal,
    required this.completionRate,
    required this.avgXpPerDay,
  });

  final int totalXp;
  final int currentLevel;
  final int xpToNextLevel;
  final int xpIntoLevel;
  final int currentStreak;
  final int longestStreak;
  final int tasksToday;
  final int tasksWeek;
  final int tasksTotal;
  final double completionRate;
  final double avgXpPerDay;

  factory DashboardStats.fromTasks(List<TaskModel> tasks, SettingsModel settings) {
    final now = DateTime.now();
    final today = startOfDay(now);
    final weekStart = now.subtract(const Duration(days: 6));

    final completed = tasks.where((task) => task.status == TaskStatus.completed).toList();
    final totalXp = completed.fold<int>(0, (sum, task) => sum + task.xp);

    final tasksToday = completed.where((task) {
      final completedAt = task.completedAt;
      if (completedAt == null) {
        return false;
      }
      return completedAt.isAfter(today);
    }).length;

    final tasksWeek = completed.where((task) {
      final completedAt = task.completedAt;
      if (completedAt == null) {
        return false;
      }
      return completedAt.isAfter(startOfDay(weekStart));
    }).length;

    final completionRate = tasks.isEmpty ? 0.0 : completed.length / tasks.length;

    final uniqueDays = completed
        .map((task) => task.completedAt)
        .whereType<DateTime>()
        .map(startOfDay)
        .toSet();

    final avgXpPerDay = uniqueDays.isEmpty ? 0.0 : totalXp / uniqueDays.length;

    final levelProgress = computeLevelProgress(totalXp);
    final completedDays = completed
        .map((task) => task.completedAt)
        .whereType<DateTime>()
        .map((value) => startOfDay(value.toUtc()))
        .toSet();

    final streakData = computeStreakMetrics(
      completedDays: completedDays,
      now: DateTime.now(),
      graceEnabled: settings.graceDayEnabled,
      graceDaysPer30: settings.graceDaysPer30,
    );

    return DashboardStats(
      totalXp: totalXp,
      currentLevel: levelProgress.level,
      xpToNextLevel: levelProgress.xpToNext,
      xpIntoLevel: levelProgress.xpIntoLevel,
      currentStreak: streakData.current,
      longestStreak: streakData.longest,
      tasksToday: tasksToday,
      tasksWeek: tasksWeek,
      tasksTotal: completed.length,
      completionRate: completionRate,
      avgXpPerDay: avgXpPerDay,
    );
  }
}
