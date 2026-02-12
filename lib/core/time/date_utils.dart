DateTime startOfDay(DateTime value) {
  if (value.isUtc) {
    return DateTime.utc(value.year, value.month, value.day);
  }
  return DateTime(value.year, value.month, value.day);
}

DateTime endOfDay(DateTime value) {
  if (value.isUtc) {
    return DateTime.utc(value.year, value.month, value.day, 23, 59, 59, 999);
  }
  return DateTime(value.year, value.month, value.day, 23, 59, 59, 999);
}
