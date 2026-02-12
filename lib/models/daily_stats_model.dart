import 'package:isar_community/isar.dart';

part 'daily_stats_model.g.dart';

@collection
class DailyStatsModel {
  DailyStatsModel({
    required this.userId,
    required this.date,
    required this.xpEarned,
    required this.tasksCompleted,
    required this.updatedAt,
  });

  Id id = Isar.autoIncrement;

  @Index()
  late String userId;

  @Index(unique: true)
  late DateTime date;

  late int xpEarned;
  late int tasksCompleted;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() {
    final dateOnly = date.toIso8601String().split('T').first;
    return {
      'user_id': userId,
      'date': dateOnly,
      'xp_earned': xpEarned,
      'tasks_completed': tasksCompleted,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory DailyStatsModel.fromJson(Map<String, dynamic> json) {
    return DailyStatsModel(
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      xpEarned: json['xp_earned'] as int,
      tasksCompleted: json['tasks_completed'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
