import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../logging/app_logger.dart';

class AppEnv {
  const AppEnv._();

  static const _urlKey = 'SUPABASE_URL';
  static const _anonKey = 'SUPABASE_ANON_KEY';

  static String? get supabaseUrl => dotenv.env[_urlKey];
  static String? get supabaseAnonKey => dotenv.env[_anonKey];

  static bool get hasSupabase {
    return (supabaseUrl?.isNotEmpty ?? false) && (supabaseAnonKey?.isNotEmpty ?? false);
  }

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: 'assets/env/.env');
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to load .env, continuing with empty config',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> initSupabaseIfConfigured() async {
    if (!hasSupabase) {
      return;
    }
    if (hasSupabase) {
      try {
        await Supabase.initialize(
          url: supabaseUrl!,
          anonKey: supabaseAnonKey!,
        );
      } catch (error, stackTrace) {
        AppLogger.warning(
          'Supabase initialization skipped due to invalid configuration',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
