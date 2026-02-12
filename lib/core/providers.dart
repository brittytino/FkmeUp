import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/consistency_engine.dart';
import '../data/local/isar/isar_service.dart';
import '../data/local/progress_local_data_source.dart';
import '../data/local/settings_local_data_source.dart';
import '../data/local/sync_queue_local_data_source.dart';
import '../data/local/task_local_data_source.dart';
import '../data/remote/progress_remote_data_source.dart';
import '../data/remote/supabase_client.dart';
import '../data/remote/task_remote_data_source.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/task_repository_impl.dart';
import '../data/sync/sync_engine.dart';
import '../data/sync/sync_status.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService.instance);

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  return IsarTaskLocalDataSource(ref.read(isarServiceProvider));
});

final syncQueueLocalDataSourceProvider = Provider<SyncQueueLocalDataSource>((ref) {
  return IsarSyncQueueLocalDataSource(ref.read(isarServiceProvider));
});

final progressLocalDataSourceProvider = Provider<ProgressLocalDataSource>((ref) {
  return IsarProgressLocalDataSource(ref.read(isarServiceProvider));
});

final supabaseClientProvider = Provider<SupabaseClientProvider>((ref) => const SupabaseClientProvider());

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource?>((ref) {
  final client = ref.read(supabaseClientProvider).client;
  if (client == null) {
    return null;
  }
  return SupabaseTaskRemoteDataSource(client);
});

final progressRemoteDataSourceProvider = Provider<ProgressRemoteDataSource?>((ref) {
  final client = ref.read(supabaseClientProvider).client;
  if (client == null) {
    return null;
  }
  return SupabaseProgressRemoteDataSource(client);
});

final consistencyEngineProvider = Provider<ConsistencyEngine>((ref) {
  return ConsistencyEngine(
    progressLocal: ref.read(progressLocalDataSourceProvider),
    settingsLocal: ref.read(settingsLocalDataSourceProvider),
    syncQueue: ref.read(syncQueueLocalDataSourceProvider),
  );
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  final engine = SyncEngine(
    queue: ref.read(syncQueueLocalDataSourceProvider),
    taskLocal: ref.read(taskLocalDataSourceProvider),
    progressLocal: ref.read(progressLocalDataSourceProvider),
    settingsLocal: ref.read(settingsLocalDataSourceProvider),
    taskRemote: ref.read(taskRemoteDataSourceProvider),
    progressRemote: ref.read(progressRemoteDataSourceProvider),
  );
  return engine;
});

final syncStatusProvider = StreamProvider<SyncStatus>((ref) {
  return ref.read(syncEngineProvider).statusStream;
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    local: ref.read(taskLocalDataSourceProvider),
    queue: ref.read(syncQueueLocalDataSourceProvider),
    progressLocal: ref.read(progressLocalDataSourceProvider),
    consistency: ref.read(consistencyEngineProvider),
    syncEngine: ref.read(syncEngineProvider),
  );
});

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  return IsarSettingsLocalDataSource(ref.read(isarServiceProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.read(settingsLocalDataSourceProvider));
});
