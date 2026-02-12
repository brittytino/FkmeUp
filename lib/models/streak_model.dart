import 'package:isar_community/isar.dart';

part 'streak_model.g.dart';

@collection
class StreakModel {
  StreakModel({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCompletionDate,
    required this.graceDaysUsed,
    required this.updatedAt,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;

  late int currentStreak;
  late int longestStreak;
  DateTime? lastCompletionDate;
  late int graceDaysUsed;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_completion_date': lastCompletionDate?.toIso8601String(),
      'grace_days_used': graceDaysUsed,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      userId: json['user_id'] as String,
      currentStreak: json['current_streak'] as int,
      longestStreak: json['longest_streak'] as int,
      lastCompletionDate: json['last_completion_date'] == null
          ? null
          : DateTime.parse(json['last_completion_date'] as String),
      graceDaysUsed: json['grace_days_used'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
