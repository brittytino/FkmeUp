int requiredXpForLevel(int level) {
  return 100 + (level * 40);
}

LevelProgress computeLevelProgress(int totalXp) {
  var level = 1;
  var remaining = totalXp;

  while (remaining >= requiredXpForLevel(level)) {
    remaining -= requiredXpForLevel(level);
    level += 1;
  }

  final xpToNext = requiredXpForLevel(level) - remaining;
  return LevelProgress(
    level: level,
    xpIntoLevel: remaining,
    xpToNext: xpToNext,
  );
}

class LevelProgress {
  LevelProgress({
    required this.level,
    required this.xpIntoLevel,
    required this.xpToNext,
  });

  final int level;
  final int xpIntoLevel;
  final int xpToNext;
}
