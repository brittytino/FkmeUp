import 'dart:convert';

import '../../core/constants/app_constants.dart';
import '../../core/services/consistency_engine.dart';
import '../../models/sync_queue_item.dart';
import '../../models/task_model.dart';
import '../local/sync_queue_local_data_source.dart';
import '../local/task_local_data_source.dart';
import '../local/progress_local_data_source.dart';
import '../sync/sync_engine.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({
    required TaskLocalDataSource local,
    required SyncQueueLocalDataSource queue,
    required ProgressLocalDataSource progressLocal,
    required ConsistencyEngine consistency,
    required SyncEngine syncEngine,
  })  : _local = local,
        _queue = queue,
        _progressLocal = progressLocal,
        _consistency = consistency,
        _syncEngine = syncEngine;

  final TaskLocalDataSource _local;
  final SyncQueueLocalDataSource _queue;
  final ProgressLocalDataSource _progressLocal;
  final ConsistencyEngine _consistency;
  final SyncEngine _syncEngine;

  @override
  Stream<List<TaskModel>> watchAll() {
    return _local.watchAll();
  }

  @override
  Future<List<TaskModel>> fetchAll() {
    return _local.fetchAll();
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await _local.upsert(task);
    await _queue.enqueue(
      SyncQueueItem(
        table: 'tasks',
        recordId: task.uuid,
        operation: SyncOperation.upsert,
        payload: jsonEncode(task.toJson()),
        updatedAt: task.updatedAt,
      ),
    );
    _syncEngine.kick();
  }

  @override
  Future<TaskCompletionResult> completeTask(TaskModel task) async {
    if (task.status == TaskStatus.completed) {
      final level = await _progressLocal.getLevel(AppConstants.localUserId);
      return TaskCompletionResult(
        xpGained: 0,
        levelBefore: level?.level ?? 1,
        levelAfter: level?.level ?? 1,
      );
    }

    final beforeLevel = await _progressLocal.getLevel(AppConstants.localUserId);
    final now = DateTime.now();
    final updated = task.copyWith(
      status: TaskStatus.completed,
      completedAt: now,
      updatedAt: now,
      xp: computeTaskXp(
        task.difficulty,
        deadline: task.deadline,
        completedAt: now,
      ),
    );
    await _local.upsert(updated);
    await _queue.enqueue(
      SyncQueueItem(
        table: 'tasks',
        recordId: task.uuid,
        operation: SyncOperation.upsert,
        payload: jsonEncode(updated.toJson()),
        updatedAt: updated.updatedAt,
      ),
    );

    final allTasks = await _local.fetchAll();
    final mergedTasks = allTasks.map((entry) => entry.uuid == updated.uuid ? updated : entry).toList();
    await _consistency.onTaskCompleted(updated, mergedTasks);
    final afterLevel = await _progressLocal.getLevel(AppConstants.localUserId);

    _syncEngine.kick();

    return TaskCompletionResult(
      xpGained: updated.xp,
      levelBefore: beforeLevel?.level ?? 1,
      levelAfter: afterLevel?.level ?? beforeLevel?.level ?? 1,
    );
  }

  @override
  Future<void> deleteTask(String uuid) async {
    await _local.deleteByUuid(uuid);
    await _queue.enqueue(
      SyncQueueItem(
        table: 'tasks',
        recordId: uuid,
        operation: SyncOperation.delete,
        payload: '{}',
        updatedAt: DateTime.now(),
      ),
    );
    _syncEngine.kick();
  }
}
