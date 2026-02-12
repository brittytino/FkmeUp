import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/daily_stats_model.dart';
import '../../models/level_model.dart';
import '../../models/streak_model.dart';

abstract class ProgressRemoteDataSource {
  Future<void> upsertDailyStats(DailyStatsModel model);
  Future<DailyStatsModel?> fetchDailyStats(String userId, DateTime date);

  Future<void> upsertLevel(LevelModel model);
  Future<LevelModel?> fetchLevel(String userId);

  Future<void> upsertStreak(StreakModel model);
  Future<StreakModel?> fetchStreak(String userId);
}

class SupabaseProgressRemoteDataSource implements ProgressRemoteDataSource {
  SupabaseProgressRemoteDataSource(this._client);

  final SupabaseClient _client;

  @override
  Future<void> upsertDailyStats(DailyStatsModel model) async {
    await _client.from('daily_stats').upsert(model.toJson());
  }

  @override
  Future<DailyStatsModel?> fetchDailyStats(String userId, DateTime date) async {
    final dateOnly = date.toIso8601String().split('T').first;
    final response = await _client
        .from('daily_stats')
        .select()
        .eq('user_id', userId)
      .eq('date', dateOnly)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return DailyStatsModel.fromJson(Map<String, dynamic>.from(response));
  }

  @override
  Future<void> upsertLevel(LevelModel model) async {
    await _client.from('levels').upsert(model.toJson());
  }

  @override
  Future<LevelModel?> fetchLevel(String userId) async {
    final response = await _client.from('levels').select().eq('user_id', userId).maybeSingle();
    if (response == null) {
      return null;
    }
    return LevelModel.fromJson(Map<String, dynamic>.from(response));
  }

  @override
  Future<void> upsertStreak(StreakModel model) async {
    await _client.from('streaks').upsert(model.toJson());
  }

  @override
  Future<StreakModel?> fetchStreak(String userId) async {
    final response = await _client.from('streaks').select().eq('user_id', userId).maybeSingle();
    if (response == null) {
      return null;
    }
    return StreakModel.fromJson(Map<String, dynamic>.from(response));
  }
}
