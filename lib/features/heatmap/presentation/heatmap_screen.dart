import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tasks/application/task_providers.dart';
import 'widgets/heatmap_grid.dart';

class HeatmapScreen extends ConsumerWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Heatmap', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Expanded(
              child: tasksAsync.when(
                data: (tasks) => HeatmapGrid(tasks: tasks),
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
