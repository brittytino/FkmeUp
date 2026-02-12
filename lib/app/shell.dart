import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers.dart';
import '../data/sync/sync_status.dart';
import '../theme/app_colors.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const _items = <_NavItem>[
    _NavItem(label: 'Dashboard', icon: Icons.dashboard_rounded, route: '/dashboard'),
    _NavItem(label: 'Tasks', icon: Icons.task_alt_rounded, route: '/tasks'),
    _NavItem(label: 'Heatmap', icon: Icons.grid_on_rounded, route: '/heatmap'),
    _NavItem(label: 'Stats', icon: Icons.insights_rounded, route: '/stats'),
    _NavItem(label: 'Settings', icon: Icons.settings_rounded, route: '/settings'),
  ];

  int _locationIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _items.indexWhere((item) => location.startsWith(item.route));
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncStatusProvider).valueOrNull ?? SyncStatus.idle;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final index = _locationIndex(context);

        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.background,
                Color(0xFF0B0D12),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                if (isWide)
                  NavigationRail(
                    selectedIndex: index,
                    onDestinationSelected: (value) {
                      context.go(_items[value].route);
                    },
                    labelType: NavigationRailLabelType.all,
                    leading: const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Icon(Icons.bolt_rounded, size: 28, color: AppColors.accentPrimary),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Icon(
                        syncStatus.phase == SyncPhase.failed
                            ? Icons.sync_problem_rounded
                            : syncStatus.phase == SyncPhase.syncing
                                ? Icons.sync_rounded
                                : Icons.cloud_done_rounded,
                        color: syncStatus.phase == SyncPhase.failed
                            ? Colors.redAccent
                            : syncStatus.phase == SyncPhase.syncing
                                ? AppColors.accentSecondary
                                : AppColors.successGlow,
                      ),
                    ),
                    destinations: _items
                        .map((item) => NavigationRailDestination(
                              icon: Icon(item.icon),
                              selectedIcon: Icon(item.icon),
                              label: Text(item.label),
                            ))
                        .toList(),
                  ),
                Expanded(child: child),
              ],
            ),
            bottomNavigationBar: isWide
                ? null
                : BottomNavigationBar(
                    currentIndex: index,
                    onTap: (value) {
                      context.go(_items[value].route);
                    },
                    items: _items
                        .map((item) => BottomNavigationBarItem(
                              icon: Icon(item.icon),
                              label: item.label,
                            ))
                        .toList(),
                  ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.icon, required this.route});

  final String label;
  final IconData icon;
  final String route;
}
