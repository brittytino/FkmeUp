import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

const _uuid = Uuid();

enum TaskStatus { pending, completed }

@collection
class TaskModel {
  TaskModel({
    required this.uuid,
    required this.title,
    required this.difficulty,
    required this.xp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deadline,
    this.completedAt,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String title;
  late int difficulty;
  late int xp;

  DateTime? deadline;

  @enumerated
  late TaskStatus status;

  late DateTime createdAt;
  DateTime? completedAt;
  late DateTime updatedAt;

  factory TaskModel.create({
    required String title,
    required int difficulty,
    DateTime? deadline,
  }) {
    final now = DateTime.now();
    return TaskModel(
      uuid: _uuid.v4(),
      title: title,
      difficulty: difficulty,
      xp: computeTaskXp(
        difficulty,
        deadline: deadline,
        completedAt: null,
      ),
      deadline: deadline,
      status: TaskStatus.pending,
      createdAt: now,
      updatedAt: now,
      completedAt: null,
    );
  }

  TaskModel copyWith({
    String? title,
    int? difficulty,
    int? xp,
    DateTime? deadline,
    TaskStatus? status,
    DateTime? completedAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      uuid: uuid,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      xp: xp ?? this.xp,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    )..id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'title': title,
      'difficulty': difficulty,
      'xp': xp,
      'deadline': deadline?.toIso8601String(),
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      uuid: json['id'] as String,
      title: json['title'] as String,
      difficulty: json['difficulty'] as int,
      xp: json['xp'] as int,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      status: TaskStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

int computeTaskXp(
  int difficulty, {
  DateTime? deadline,
  DateTime? completedAt,
}) {
  final clampedDifficulty = difficulty.clamp(1, 5);
  var xp = clampedDifficulty * 20;
  if (deadline != null && completedAt != null && completedAt.isBefore(deadline)) {
    xp += 10;
  }
  return xp.clamp(0, 2147483647);
}
