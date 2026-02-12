import 'package:flutter/material.dart';

class TaskFormDialog extends StatefulWidget {
  const TaskFormDialog({super.key});

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _titleController = TextEditingController();
  int _difficulty = 3;
  DateTime? _deadline;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Difficulty'),
                Expanded(
                  child: Slider(
                    value: _difficulty.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _difficulty.toString(),
                    onChanged: (value) => setState(() => _difficulty = value.round()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(_deadline == null
                    ? 'No deadline'
                    : _deadline!.toLocal().toString().substring(0, 16)),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final date = await showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365)),
                      initialDate: now,
                    );
                    if (date == null) {
                      return;
                    }
                    if (!context.mounted) {
                      return;
                    }
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(now),
                    );
                    if (time == null || !context.mounted) {
                      return;
                    }
                    setState(() {
                      _deadline = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  },
                  child: const Text('Set Deadline'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              return;
            }
            Navigator.of(context).pop(
              TaskFormResult(
                title: _titleController.text.trim(),
                difficulty: _difficulty,
                deadline: _deadline,
              ),
            );
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class TaskFormResult {
  TaskFormResult({
    required this.title,
    required this.difficulty,
    required this.deadline,
  });

  final String title;
  final int difficulty;
  final DateTime? deadline;
}
