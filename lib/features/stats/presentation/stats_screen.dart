import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/time/date_utils.dart';
import '../../../models/task_model.dart';
import '../../../theme/app_colors.dart';
import '../../tasks/application/task_providers.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stats', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Expanded(
              child: tasksAsync.when(
                data: (tasks) => _StatsBody(tasks: tasks),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final weekly = _weeklyXp();
    final monthly = _monthlyCompletion();

    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly XP', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              if (value.toInt() < 0 || value.toInt() >= weekly.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(weekly[value.toInt()].label);
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: weekly
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(entry.key.toDouble(), entry.value.value.toDouble()))
                              .toList(),
                          isCurved: true,
                          barWidth: 3,
                          color: AppColors.accentPrimary,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentPrimary.withOpacity(0.4),
                                AppColors.accentSecondary.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Monthly Completions', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              if (value.toInt() < 0 || value.toInt() >= monthly.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(monthly[value.toInt()].label);
                            },
                          ),
                        ),
                      ),
                      barGroups: monthly
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value.value.toDouble(),
                                  width: 18,
                                  gradient: const LinearGradient(
                                    colors: [AppColors.accentPrimary, AppColors.accentSecondary],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<_ChartPoint> _weeklyXp() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = startOfDay(now.subtract(Duration(days: 6 - index)));
      final xp = tasks
          .where((task) => task.completedAt != null && startOfDay(task.completedAt!) == day)
          .fold<int>(0, (sum, task) => sum + task.xp);
      return _ChartPoint(label: DateFormat('E').format(day), value: xp);
    });
  }

  List<_ChartPoint> _monthlyCompletion() {
    final now = DateTime.now();
    return List.generate(6, (index) {
      final month = DateTime(now.year, now.month - (5 - index));
      final count = tasks.where((task) {
        final completedAt = task.completedAt;
        if (completedAt == null) {
          return false;
        }
        return completedAt.year == month.year && completedAt.month == month.month;
      }).length;
      return _ChartPoint(label: DateFormat('MMM').format(month), value: count);
    });
  }
}

class _ChartPoint {
  _ChartPoint({required this.label, required this.value});

  final String label;
  final int value;
}
