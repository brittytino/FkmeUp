import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/glow.dart';
import '../../../../utils/formatters.dart';
import '../../application/task_providers.dart';
import '../../../../models/task_model.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({required this.task, super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deadlineLabel = task.deadline == null
        ? 'No deadline'
        : DateFormat('MMM d, HH:mm').format(task.deadline!);

    return GlowContainer(
      glowColor: task.status == TaskStatus.completed
          ? AppColors.successGlow
          : AppColors.accentPrimary,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                task.status == TaskStatus.completed
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: task.status == TaskStatus.completed
                    ? AppColors.successGlow
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Difficulty ${task.difficulty} • $deadlineLabel',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Text(
                '${formatXp(task.xp)} XP',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentSecondary,
                ),
              ),
              const SizedBox(width: 12),
              if (task.status == TaskStatus.pending)
                FilledButton(
                  onPressed: () async {
                    final result = await ref.read(taskControllerProvider).completeTask(task);
                    if (!context.mounted) {
                      return;
                    }

                    final overlayState = Overlay.of(context);
                    final entry = OverlayEntry(
                      builder: (context) => Positioned(
                        top: 80,
                        right: 24,
                        child: _XpGainChip(xp: result.xpGained),
                      ),
                    );
                    overlayState.insert(entry);
                    await Future<void>.delayed(const Duration(milliseconds: 900));
                    entry.remove();

                    if (result.didLevelUp && context.mounted) {
                      await showGeneralDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'Level Up',
                        barrierColor: Colors.black54,
                        transitionDuration: const Duration(milliseconds: 260),
                        pageBuilder: (context, _, __) {
                          return Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.bolt_rounded,
                                        color: AppColors.successGlow, size: 40),
                                    const SizedBox(height: 8),
                                    const Text('Level Up!',
                                        style: TextStyle(
                                            fontSize: 22, fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 8),
                                    Text('Level ${result.levelAfter} reached'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        transitionBuilder: (context, animation, _, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.94, end: 1).animate(animation),
                              child: child,
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Complete'),
                ),
              if (task.status == TaskStatus.completed)
                IconButton(
                  onPressed: () async {
                    await ref.read(taskControllerProvider).deleteTask(task.uuid);
                  },
                  icon: const Icon(Icons.delete_rounded, color: AppColors.textSecondary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _XpGainChip extends StatefulWidget {
  const _XpGainChip({required this.xp});

  final int xp;

  @override
  State<_XpGainChip> createState() => _XpGainChipState();
}

class _XpGainChipState extends State<_XpGainChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(_fade);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.successGlow.withOpacity(0.3),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            '+${widget.xp} XP',
            style: const TextStyle(
              color: AppColors.successGlow,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
