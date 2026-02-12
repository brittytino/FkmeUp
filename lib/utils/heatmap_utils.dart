import '../core/time/date_utils.dart';
import '../models/task_model.dart';

Map<DateTime, int> aggregateHeatmapXp(List<TaskModel> tasks) {
  final dayMap = <DateTime, int>{};
  for (final task in tasks) {
    if (task.completedAt == null || task.status != TaskStatus.completed) {
      continue;
    }

    final day = startOfDay(task.completedAt!.toUtc());
    dayMap[day] = (dayMap[day] ?? 0) + task.xp;
  }

  return dayMap;
}
