import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger._();

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'FkmeUp',
      level: 800,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'FkmeUp',
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'FkmeUp',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void reportFlutterError(FlutterErrorDetails details) {
    error(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
  }
}
