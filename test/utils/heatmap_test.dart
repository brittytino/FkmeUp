import 'package:flutter_test/flutter_test.dart';
import 'package:fkmeup/models/task_model.dart';
import 'package:fkmeup/utils/heatmap_utils.dart';

void main() {
  test('aggregates daily XP from completed tasks only', () {
    final day = DateTime.utc(2026, 2, 12, 10);
    final taskA = TaskModel.create(title: 'A', difficulty: 2).copyWith(
      status: TaskStatus.completed,
      xp: 40,
      completedAt: day,
      updatedAt: DateTime.utc(2026, 2, 12, 11),
    );
    final taskB = TaskModel.create(title: 'B', difficulty: 3).copyWith(
      status: TaskStatus.completed,
      xp: 60,
      completedAt: DateTime.utc(2026, 2, 12, 13),
      updatedAt: DateTime.utc(2026, 2, 12, 14),
    );
    final pending = TaskModel.create(title: 'C', difficulty: 1);

    final result = aggregateHeatmapXp([taskA, taskB, pending]);

    expect(result.length, 1);
    expect(result.values.first, 100);
  });
}
