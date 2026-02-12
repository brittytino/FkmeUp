import 'package:isar_community/isar.dart';

import '../../models/daily_stats_model.dart';
import '../../models/level_model.dart';
import '../../models/streak_model.dart';
import 'isar/isar_service.dart';

abstract class ProgressLocalDataSource {
  Future<DailyStatsModel?> getDailyStatsByDate(DateTime date);
  Future<void> upsertDailyStats(DailyStatsModel model);
  Stream<List<DailyStatsModel>> watchDailyStats();
  Future<List<DailyStatsModel>> fetchDailyStats();

  Future<LevelModel?> getLevel(String userId);
  Future<void> upsertLevel(LevelModel model);
  Stream<LevelModel?> watchLevel(String userId);

  Future<StreakModel?> getStreak(String userId);
  Future<void> upsertStreak(StreakModel model);
  Stream<StreakModel?> watchStreak(String userId);
}

class IsarProgressLocalDataSource implements ProgressLocalDataSource {
  IsarProgressLocalDataSource(this._isarService);

  final IsarService _isarService;

  @override
  Future<DailyStatsModel?> getDailyStatsByDate(DateTime date) async {
    final isar = await _isarService.db;
    return isar.dailyStatsModels.filter().dateEqualTo(date).findFirst();
  }

  @override
  Future<void> upsertDailyStats(DailyStatsModel model) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.dailyStatsModels.put(model);
    });
  }

  @override
  Stream<List<DailyStatsModel>> watchDailyStats() async* {
    final isar = await _isarService.db;
    yield* isar.dailyStatsModels.where().watch(fireImmediately: true);
  }

  @override
  Future<List<DailyStatsModel>> fetchDailyStats() async {
    final isar = await _isarService.db;
    return isar.dailyStatsModels.where().findAll();
  }

  @override
  Future<LevelModel?> getLevel(String userId) async {
    final isar = await _isarService.db;
    return isar.levelModels.filter().userIdEqualTo(userId).findFirst();
  }

  @override
  Future<void> upsertLevel(LevelModel model) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.levelModels.put(model);
    });
  }

  @override
  Stream<LevelModel?> watchLevel(String userId) async* {
    final isar = await _isarService.db;
    yield* isar.levelModels
        .filter()
        .userIdEqualTo(userId)
        .watch(fireImmediately: true)
        .map((List<LevelModel> levels) => levels.isEmpty ? null : levels.first);
  }

  @override
  Future<StreakModel?> getStreak(String userId) async {
    final isar = await _isarService.db;
    return isar.streakModels.filter().userIdEqualTo(userId).findFirst();
  }

  @override
  Future<void> upsertStreak(StreakModel model) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.streakModels.put(model);
    });
  }

  @override
  Stream<StreakModel?> watchStreak(String userId) async* {
    final isar = await _isarService.db;
    yield* isar.streakModels
        .filter()
        .userIdEqualTo(userId)
        .watch(fireImmediately: true)
        .map((List<StreakModel> streaks) => streaks.isEmpty ? null : streaks.first);
  }
}
