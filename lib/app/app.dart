import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../theme/app_theme.dart';
import 'router.dart';

class FkmeUpApp extends ConsumerStatefulWidget {
  const FkmeUpApp({super.key});

  @override
  ConsumerState<FkmeUpApp> createState() => _FkmeUpAppState();
}

class _FkmeUpAppState extends ConsumerState<FkmeUpApp> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(() => ref.read(syncEngineProvider).kick());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FkmeUp',
      theme: AppTheme.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
