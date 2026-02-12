import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../models/task_model.dart';

enum TaskFilter { all, pending, completed }

final taskListProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.read(taskRepositoryProvider).watchAll();
});

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);

final filteredTasksProvider = Provider<AsyncValue<List<TaskModel>>>((ref) {
  final filter = ref.watch(taskFilterProvider);
  final tasksAsync = ref.watch(taskListProvider);

  return tasksAsync.whenData((tasks) {
    switch (filter) {
      case TaskFilter.pending:
        return tasks.where((task) => task.status == TaskStatus.pending).toList();
      case TaskFilter.completed:
        return tasks.where((task) => task.status == TaskStatus.completed).toList();
      case TaskFilter.all:
        return tasks;
    }
  });
});

final taskControllerProvider = Provider<TaskController>((ref) {
  return TaskController(ref.read(taskRepositoryProvider));
});

class TaskController {
  TaskController(this._repository);

  final TaskRepository _repository;

  Future<void> addTask({
    required String title,
    required int difficulty,
    DateTime? deadline,
  }) async {
    final task = TaskModel.create(
      title: title,
      difficulty: difficulty,
      deadline: deadline,
    );
    await _repository.addTask(task);
  }

  Future<TaskCompletionResult> completeTask(TaskModel task) async {
    return _repository.completeTask(task);
  }

  Future<void> deleteTask(String uuid) async {
    await _repository.deleteTask(uuid);
  }
}
