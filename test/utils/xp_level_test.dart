import 'package:flutter_test/flutter_test.dart';
import 'package:fkmeup/models/task_model.dart';
import 'package:fkmeup/utils/level_utils.dart';

void main() {
  group('XP calculation', () {
    test('uses difficulty and early deadline bonus once', () {
      final deadline = DateTime.utc(2026, 2, 20);
      final completedAt = DateTime.utc(2026, 2, 19);

      final xp = computeTaskXp(3, deadline: deadline, completedAt: completedAt);

      expect(xp, 70);
    });

    test('clamps difficulty and prevents negative/overflow XP', () {
      final low = computeTaskXp(-4);
      final high = computeTaskXp(1000);

      expect(low, 20);
      expect(high, greaterThan(0));
    });
  });

  group('Level formula', () {
    test('progress follows required_xp = 100 + level * 40', () {
      final progress = computeLevelProgress(300);

      expect(progress.level, 2);
      expect(progress.xpToNext, 20);
    });
  });
}
