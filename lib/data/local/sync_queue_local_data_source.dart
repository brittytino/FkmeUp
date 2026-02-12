import 'package:isar_community/isar.dart';

import '../../models/sync_queue_item.dart';
import 'isar/isar_service.dart';

abstract class SyncQueueLocalDataSource {
  Stream<List<SyncQueueItem>> watchAll();
  Future<List<SyncQueueItem>> fetchAll();
  Future<void> enqueue(SyncQueueItem item);
  Future<void> update(SyncQueueItem item);
  Future<void> deleteById(Id id);
}

class IsarSyncQueueLocalDataSource implements SyncQueueLocalDataSource {
  IsarSyncQueueLocalDataSource(this._isarService);

  final IsarService _isarService;

  @override
  Stream<List<SyncQueueItem>> watchAll() async* {
    final isar = await _isarService.db;
    yield* isar.syncQueueItems.where().watch(fireImmediately: true);
  }

  @override
  Future<List<SyncQueueItem>> fetchAll() async {
    final isar = await _isarService.db;
    return isar.syncQueueItems.where().findAll();
  }

  @override
  Future<void> enqueue(SyncQueueItem item) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.syncQueueItems.put(item);
    });
  }

  @override
  Future<void> update(SyncQueueItem item) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.syncQueueItems.put(item);
    });
  }

  @override
  Future<void> deleteById(Id id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.syncQueueItems.delete(id);
    });
  }
}
