import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';
import '../application/task_providers.dart';
import 'widgets/task_card.dart';
import 'widgets/task_form_dialog.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(filteredTasksProvider);
    final filter = ref.watch(taskFilterProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tasks', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                FilledButton.icon(
                  onPressed: () async {
                    final result = await showDialog<TaskFormResult>(
                      context: context,
                      builder: (context) => const TaskFormDialog(),
                    );
                    if (result == null) {
                      return;
                    }
                    await ref.read(taskControllerProvider).addTask(
                          title: result.title,
                          difficulty: result.difficulty,
                          deadline: result.deadline,
                        );
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('New Task'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: TaskFilter.values
                  .map(
                    (value) => ChoiceChip(
                      label: Text(value.name.toUpperCase()),
                      selected: filter == value,
                      onSelected: (_) => ref.read(taskFilterProvider.notifier).state = value,
                      selectedColor: AppColors.accentPrimary,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: tasksAsync.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return const Center(
                      child: Text('No tasks yet. Add one and start the streak.'),
                    );
                  }
                  return ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskCard(task: task);
                    },
                  );
                },
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
