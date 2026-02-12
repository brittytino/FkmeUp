import 'package:isar_community/isar.dart';

part 'sync_queue_item.g.dart';

enum SyncOperation { upsert, delete }

@collection
class SyncQueueItem {
  SyncQueueItem({
    required this.table,
    required this.recordId,
    required this.operation,
    required this.payload,
    required this.updatedAt,
    this.retryCount = 0,
    this.nextRetryAt,
    this.lastError,
  });

  Id id = Isar.autoIncrement;

  late String table;
  late String recordId;

  @enumerated
  late SyncOperation operation;

  late String payload;
  late DateTime updatedAt;
  late int retryCount;
  DateTime? nextRetryAt;
  String? lastError;

  Map<String, dynamic> toJson() {
    return {
      'table': table,
      'record_id': recordId,
      'operation': operation.name,
      'payload': payload,
      'updated_at': updatedAt.toIso8601String(),
      'retry_count': retryCount,
      'next_retry_at': nextRetryAt?.toIso8601String(),
      'last_error': lastError,
    };
  }

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) {
    return SyncQueueItem(
      table: json['table'] as String,
      recordId: json['record_id'] as String,
      operation: SyncOperation.values.firstWhere(
        (value) => value.name == json['operation'],
        orElse: () => SyncOperation.upsert,
      ),
      payload: json['payload'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      retryCount: (json['retry_count'] as int?) ?? 0,
      nextRetryAt: json['next_retry_at'] == null
          ? null
          : DateTime.parse(json['next_retry_at'] as String),
      lastError: json['last_error'] as String?,
    );
  }
}
