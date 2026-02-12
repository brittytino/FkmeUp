import 'package:isar_community/isar.dart';

import '../../models/task_model.dart';
import 'isar/isar_service.dart';

abstract class TaskLocalDataSource {
  Stream<List<TaskModel>> watchAll();
  Future<List<TaskModel>> fetchAll();
  Future<void> upsert(TaskModel task);
  Future<void> deleteByUuid(String uuid);
  Future<TaskModel?> getByUuid(String uuid);
}

class IsarTaskLocalDataSource implements TaskLocalDataSource {
  IsarTaskLocalDataSource(this._isarService);

  final IsarService _isarService;

  @override
  Stream<List<TaskModel>> watchAll() async* {
    final isar = await _isarService.db;
    yield* isar.taskModels.where().watch(fireImmediately: true);
  }

  @override
  Future<List<TaskModel>> fetchAll() async {
    final isar = await _isarService.db;
    return isar.taskModels.where().findAll();
  }

  @override
  Future<TaskModel?> getByUuid(String uuid) async {
    final isar = await _isarService.db;
    return isar.taskModels.filter().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<void> upsert(TaskModel task) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.taskModels.put(task);
    });
  }

  @override
  Future<void> deleteByUuid(String uuid) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.taskModels.filter().uuidEqualTo(uuid).deleteAll();
    });
  }
}
