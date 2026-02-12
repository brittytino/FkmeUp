import 'package:isar_community/isar.dart';

part 'level_model.g.dart';

@collection
class LevelModel {
  LevelModel({
    required this.userId,
    required this.totalXp,
    required this.level,
    required this.xpToNextLevel,
    required this.updatedAt,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String userId;

  late int totalXp;
  late int level;
  late int xpToNextLevel;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_xp': totalXp,
      'level': level,
      'xp_to_next_level': xpToNextLevel,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      userId: json['user_id'] as String,
      totalXp: json['total_xp'] as int,
      level: json['level'] as int,
      xpToNextLevel: json['xp_to_next_level'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
