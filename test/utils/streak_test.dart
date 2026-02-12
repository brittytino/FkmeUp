import 'package:flutter_test/flutter_test.dart';
import 'package:fkmeup/core/time/date_utils.dart';
import 'package:fkmeup/utils/streak_utils.dart';

void main() {
  group('Streak metrics', () {
    test('resets when missing day without grace', () {
      final now = DateTime.utc(2026, 2, 12);
      final completedDays = <DateTime>{
        startOfDay(now.toUtc()),
        startOfDay(now.subtract(const Duration(days: 2)).toUtc()),
      };

      final result = computeStreakMetrics(
        completedDays: completedDays,
        now: now,
        graceEnabled: false,
        graceDaysPer30: 0,
      );

      expect(result.current, 1);
    });

    test('uses grace day when enabled', () {
      final now = DateTime.utc(2026, 2, 12);
      final completedDays = <DateTime>{
        startOfDay(now.toUtc()),
        startOfDay(now.subtract(const Duration(days: 2)).toUtc()),
      };

      final result = computeStreakMetrics(
        completedDays: completedDays,
        now: now,
        graceEnabled: true,
        graceDaysPer30: 1,
      );

      expect(result.current, 3);
      expect(result.graceUsed, 1);
    });
  });
}
