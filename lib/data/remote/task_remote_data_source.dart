import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<void> upsert(TaskModel task);
  Future<void> delete(String uuid);
  Future<TaskModel?> fetchByUuid(String uuid);
}

class SupabaseTaskRemoteDataSource implements TaskRemoteDataSource {
  SupabaseTaskRemoteDataSource(this._client);

  final SupabaseClient _client;

  @override
  Future<void> upsert(TaskModel task) async {
    await _client.from('tasks').upsert(task.toJson());
  }

  @override
  Future<void> delete(String uuid) async {
    await _client.from('tasks').delete().eq('id', uuid);
  }

  @override
  Future<TaskModel?> fetchByUuid(String uuid) async {
    final response = await _client.from('tasks').select().eq('id', uuid).maybeSingle();
    if (response == null) {
      return null;
    }
    return TaskModel.fromJson(Map<String, dynamic>.from(response));
  }
}
