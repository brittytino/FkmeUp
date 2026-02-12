import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import 'app/app.dart';
import 'app/app_error_boundary.dart';
import 'data/local/isar/isar_service.dart';
import 'core/env/app_env.dart';
import 'core/logging/app_logger.dart';
import 'models/settings_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.reportFlutterError(details);
  };

  await runZonedGuarded(
    () async {
      await AppEnv.load();

      final isar = await IsarService.instance.db;
      final settings = await isar.settingsModels.where().anyId().findFirst();
      final shouldEnableSync = settings?.syncEnabled ?? true;
      if (shouldEnableSync) {
        await AppEnv.initSupabaseIfConfigured();
      }

      runApp(
        const ProviderScope(
          child: AppErrorBoundary(
            child: FkmeUpApp(),
          ),
        ),
      );
    },
    (Object error, StackTrace stackTrace) {
      AppLogger.error('Unhandled zone error', error: error, stackTrace: stackTrace);
    },
  );
}
