import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/daily_stats_model.dart';
import '../../../models/level_model.dart';
import '../../../models/settings_model.dart';
import '../../../models/streak_model.dart';
import '../../../models/sync_queue_item.dart';
import '../../../models/task_model.dart';

class IsarService {
  IsarService._();

  static final IsarService instance = IsarService._();

  Isar? _isar;

  Future<Isar> get db async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        TaskModelSchema,
        DailyStatsModelSchema,
        StreakModelSchema,
        LevelModelSchema,
        SyncQueueItemSchema,
        SettingsModelSchema,
      ],
      directory: dir.path,
    );
    return _isar!;
  }
}
