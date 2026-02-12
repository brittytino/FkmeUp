import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../../../../core/time/date_utils.dart';
import '../../../../models/task_model.dart';
import '../../../../utils/heatmap_utils.dart';

class HeatmapGrid extends StatelessWidget {
  const HeatmapGrid({required this.tasks, super.key});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final dayMap = aggregateHeatmapXp(tasks);

    final today = startOfDay(DateTime.now());
    final days = List.generate(365, (index) {
      return today.subtract(Duration(days: 364 - index));
    });

    final maxXp = dayMap.values.isEmpty ? 1 : dayMap.values.reduce((a, b) => a > b ? a : b);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final xp = dayMap[day] ?? 0;
        final color = _colorForXp(xp, maxXp);

        return Tooltip(
          message: '${DateFormat('MMM d, yyyy').format(day)} • $xp XP',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              boxShadow: xp > 0
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
          ),
        );
      },
    );
  }

  Color _colorForXp(int xp, int maxXp) {
    if (xp == 0) {
      return AppColors.heatmapEmpty;
    }
    final ratio = xp / maxXp;
    if (ratio < 0.33) {
      return AppColors.accentPrimary.withOpacity(0.4);
    }
    if (ratio < 0.66) {
      return AppColors.accentSecondary.withOpacity(0.7);
    }
    return AppColors.successGlow;
  }
}
