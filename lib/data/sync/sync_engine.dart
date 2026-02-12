import 'dart:async';
import 'dart:convert';

import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';
import '../../models/daily_stats_model.dart';
import '../../models/level_model.dart';
import '../../models/streak_model.dart';
import '../../models/sync_queue_item.dart';
import '../../models/task_model.dart';
import '../local/progress_local_data_source.dart';
import '../local/settings_local_data_source.dart';
import '../local/sync_queue_local_data_source.dart';
import '../local/task_local_data_source.dart';
import '../remote/progress_remote_data_source.dart';
import '../remote/task_remote_data_source.dart';
import 'sync_status.dart';

class SyncEngine {
  SyncEngine({
    required SyncQueueLocalDataSource queue,
    required TaskLocalDataSource taskLocal,
    required ProgressLocalDataSource progressLocal,
    required SettingsLocalDataSource settingsLocal,
    required TaskRemoteDataSource? taskRemote,
    required ProgressRemoteDataSource? progressRemote,
  })  : _queue = queue,
        _taskLocal = taskLocal,
        _progressLocal = progressLocal,
        _settingsLocal = settingsLocal,
        _taskRemote = taskRemote,
        _progressRemote = progressRemote;

  final SyncQueueLocalDataSource _queue;
  final TaskLocalDataSource _taskLocal;
  final ProgressLocalDataSource _progressLocal;
  final SettingsLocalDataSource _settingsLocal;
  final TaskRemoteDataSource? _taskRemote;
  final ProgressRemoteDataSource? _progressRemote;

  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  bool _isSyncing = false;
  Timer? _timer;

  Stream<SyncStatus> get statusStream async* {
    yield SyncStatus.idle;
    yield* _statusController.stream;
  }

  void kick({Duration delay = const Duration(milliseconds: 250)}) {
    _timer?.cancel();
    _timer = Timer(delay, () {
      unawaited(_sync());
    });
  }

  Future<void> _sync() async {
    if (_isSyncing) {
      return;
    }

    final settings = await _settingsLocal.fetch();
    if (settings != null && !settings.syncEnabled) {
      return;
    }

    if (_taskRemote == null || _progressRemote == null) {
      return;
    }

    _isSyncing = true;

    try {
      final items = await _queue.fetchAll();
      final now = DateTime.now();
      final dueItems = items
          .where((item) => item.nextRetryAt == null || !item.nextRetryAt!.isAfter(now))
          .toList();

      _statusController.add(
        SyncStatus(phase: SyncPhase.syncing, pendingItems: dueItems.length),
      );

      for (final item in dueItems) {
        await _processItem(item);
      }

      final remaining = await _queue.fetchAll();
      _statusController.add(
        SyncStatus(phase: SyncPhase.success, pendingItems: remaining.length),
      );
    } catch (error, stackTrace) {
      AppLogger.error('Sync failed', error: error, stackTrace: stackTrace);
      final remaining = await _queue.fetchAll();
      _statusController.add(
        SyncStatus(
          phase: SyncPhase.failed,
          pendingItems: remaining.length,
          lastError: error.toString(),
        ),
      );
      kick(delay: const Duration(seconds: 2));
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processItem(SyncQueueItem item) async {
    try {
      switch (item.table) {
        case 'tasks':
          await _syncTask(item);
          break;
        case 'daily_stats':
          await _syncDailyStats(item);
          break;
        case 'streaks':
          await _syncStreak(item);
          break;
        case 'levels':
          await _syncLevel(item);
          break;
        default:
          break;
      }
      await _queue.deleteById(item.id);
    } catch (error) {
      final retryCount = item.retryCount + 1;
      final backoffSeconds = retryCount <= 6 ? (1 << retryCount) : 60;
      final updated = SyncQueueItem(
        table: item.table,
        recordId: item.recordId,
        operation: item.operation,
        payload: item.payload,
        updatedAt: item.updatedAt,
        retryCount: retryCount,
        nextRetryAt: DateTime.now().add(Duration(seconds: backoffSeconds)),
        lastError: error.toString(),
      )..id = item.id;
      await _queue.update(updated);
      rethrow;
    }
  }

  Future<void> _syncTask(SyncQueueItem item) async {
    if (item.operation == SyncOperation.delete) {
      await _taskRemote!.delete(item.recordId);
      return;
    }

    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final localTask = TaskModel.fromJson(payload);
    final remoteTask = await _taskRemote!.fetchByUuid(item.recordId);

    if (remoteTask == null || localTask.updatedAt.isAfter(remoteTask.updatedAt)) {
      await _taskRemote.upsert(localTask);
      return;
    }

    await _taskLocal.upsert(remoteTask);
  }

  Future<void> _syncDailyStats(SyncQueueItem item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final local = DailyStatsModel.fromJson(payload);
    final remote = await _progressRemote!.fetchDailyStats(local.userId, local.date);

    if (remote == null || local.updatedAt.isAfter(remote.updatedAt)) {
      await _progressRemote.upsertDailyStats(local);
      return;
    }

    await _progressLocal.upsertDailyStats(remote);
  }

  Future<void> _syncStreak(SyncQueueItem item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final local = StreakModel.fromJson(payload);
    final remote = await _progressRemote!.fetchStreak(local.userId);

    if (remote == null || local.updatedAt.isAfter(remote.updatedAt)) {
      await _progressRemote.upsertStreak(local);
      return;
    }

    await _progressLocal.upsertStreak(remote);
  }

  Future<void> _syncLevel(SyncQueueItem item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final local = LevelModel.fromJson(payload);
    final remote = await _progressRemote!.fetchLevel(local.userId);

    if (remote == null || local.updatedAt.isAfter(remote.updatedAt)) {
      await _progressRemote.upsertLevel(local);
      return;
    }

    await _progressLocal.upsertLevel(remote);
  }

  Future<void> seedProgressPull() async {
    if (_taskRemote == null || _progressRemote == null) {
      return;
    }

    final remoteLevel = await _progressRemote.fetchLevel(AppConstants.localUserId);
    final remoteStreak = await _progressRemote.fetchStreak(AppConstants.localUserId);

    if (remoteLevel != null) {
      final local = await _progressLocal.getLevel(AppConstants.localUserId);
      if (local == null || remoteLevel.updatedAt.isAfter(local.updatedAt)) {
        await _progressLocal.upsertLevel(remoteLevel);
      }
    }

    if (remoteStreak != null) {
      final local = await _progressLocal.getStreak(AppConstants.localUserId);
      if (local == null || remoteStreak.updatedAt.isAfter(local.updatedAt)) {
        await _progressLocal.upsertStreak(remoteStreak);
      }
    }
  }
}
