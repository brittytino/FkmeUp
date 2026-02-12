import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppErrorBoundary extends StatefulWidget {
  const AppErrorBoundary({required this.child, super.key});

  final Widget child;

  @override
  State<AppErrorBoundary> createState() => _AppErrorBoundaryState();
}

class _AppErrorBoundaryState extends State<AppErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      _error = details.exception;
      _stackTrace = details.stack;
      return _buildFallback();
    };

    if (_error != null) {
      return _buildFallback();
    }

    return widget.child;
  }

  Widget _buildFallback() {
    return Material(
      color: AppColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, color: AppColors.accentSecondary, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'A recoverable UI error occurred.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  _error?.toString() ?? 'Unknown error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                if (_stackTrace != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _stackTrace.toString(),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
