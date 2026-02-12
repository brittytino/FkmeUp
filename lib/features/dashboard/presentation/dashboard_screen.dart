import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/glow.dart';
import '../../../utils/formatters.dart';
import '../application/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: statsAsync.when(
          data: (stats) {
            final progress = stats.xpIntoLevel / (stats.xpIntoLevel + stats.xpToNextLevel);
            return ListView(
              children: [
                const Text('Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                GlowContainer(
                  glowColor: AppColors.accentPrimary,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Level ${stats.currentLevel}', style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 8),
                          Text('${formatXp(stats.totalXp)} XP Total',
                              style: const TextStyle(color: AppColors.textSecondary)),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Container(
                                  height: 14,
                                  color: AppColors.surfaceAlt,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 280),
                                  height: 14,
                                  width: (MediaQuery.of(context).size.width - 120) * progress,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.accentPrimary, AppColors.accentSecondary],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('${stats.xpToNextLevel} XP to next level',
                              style: const TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _StatCard(label: 'Current Streak', value: '${stats.currentStreak} days'),
                    _StatCard(label: 'Longest Streak', value: '${stats.longestStreak} days'),
                    _StatCard(label: 'Tasks Today', value: '${stats.tasksToday}'),
                    _StatCard(label: 'Tasks This Week', value: '${stats.tasksWeek}'),
                    _StatCard(label: 'Completion Rate', value: '${(stats.completionRate * 100).toStringAsFixed(0)}%'),
                    _StatCard(label: 'Avg XP / Day', value: formatXp(stats.avgXpPerDay.round())),
                  ],
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
