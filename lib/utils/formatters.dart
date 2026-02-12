String formatXp(int xp) {
  if (xp >= 1000) {
    final value = xp / 1000.0;
    return '${value.toStringAsFixed(1)}k';
  }
  return xp.toString();
}
