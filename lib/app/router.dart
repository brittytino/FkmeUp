import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/heatmap/presentation/heatmap_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/stats/presentation/stats_screen.dart';
import '../features/tasks/presentation/tasks_screen.dart';
import 'shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  errorBuilder: (BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Route not found'),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go Dashboard'),
            ),
          ],
        ),
      ),
    );
  },
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return AppShell(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => _fadePage(const DashboardScreen()),
        ),
        GoRoute(
          path: '/tasks',
          pageBuilder: (context, state) => _fadePage(const TasksScreen()),
        ),
        GoRoute(
          path: '/heatmap',
          pageBuilder: (context, state) => _fadePage(const HeatmapScreen()),
        ),
        GoRoute(
          path: '/stats',
          pageBuilder: (context, state) => _fadePage(const StatsScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => _fadePage(const SettingsScreen()),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _fadePage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
