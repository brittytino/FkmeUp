import '../core/time/date_utils.dart';

class StreakMetrics {
  const StreakMetrics({
    required this.current,
    required this.longest,
    required this.graceUsed,
  });

  final int current;
  final int longest;
  final int graceUsed;
}

StreakMetrics computeStreakMetrics({
  required Set<DateTime> completedDays,
  required DateTime now,
  required bool graceEnabled,
  required int graceDaysPer30,
}) {
  final normalized = completedDays.map((day) => startOfDay(day.toUtc())).toSet();
  final today = startOfDay(now.toUtc());

  var current = 0;
  var graceRemaining = graceEnabled ? graceDaysPer30 : 0;

  for (var i = 0; i < 365; i++) {
    final day = today.subtract(Duration(days: i));
    if (normalized.contains(day)) {
      current += 1;
      continue;
    }

    if (graceRemaining > 0) {
      graceRemaining -= 1;
      current += 1;
      continue;
    }

    break;
  }

  var longest = 0;
  var running = 0;
  for (var i = 365; i >= 0; i--) {
    final day = today.subtract(Duration(days: i));
    if (normalized.contains(day)) {
      running += 1;
      if (running > longest) {
        longest = running;
      }
    } else {
      running = 0;
    }
  }

  return StreakMetrics(
    current: current,
    longest: longest,
    graceUsed: graceEnabled ? graceDaysPer30 - graceRemaining : 0,
  );
}
