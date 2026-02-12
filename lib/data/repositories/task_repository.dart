import '../../models/task_model.dart';

abstract class TaskRepository {
  Stream<List<TaskModel>> watchAll();
  Future<List<TaskModel>> fetchAll();
  Future<void> addTask(TaskModel task);
  Future<TaskCompletionResult> completeTask(TaskModel task);
  Future<void> deleteTask(String uuid);
}

class TaskCompletionResult {
  const TaskCompletionResult({
    required this.xpGained,
    required this.levelBefore,
    required this.levelAfter,
  });

  final int xpGained;
  final int levelBefore;
  final int levelAfter;

  bool get didLevelUp => levelAfter > levelBefore;
}
