import 'package:isar_community/isar.dart';

import '../../models/settings_model.dart';
import 'isar/isar_service.dart';

abstract class SettingsLocalDataSource {
  Stream<SettingsModel?> watch();
  Future<SettingsModel?> fetch();
  Future<void> save(SettingsModel settings);
}

class IsarSettingsLocalDataSource implements SettingsLocalDataSource {
  IsarSettingsLocalDataSource(this._isarService);

  final IsarService _isarService;

  @override
  Stream<SettingsModel?> watch() async* {
    final isar = await _isarService.db;
    yield* isar.settingsModels.where().watch(fireImmediately: true).map(
          (settings) => settings.isEmpty ? null : settings.first,
        );
  }

  @override
  Future<SettingsModel?> fetch() async {
    final isar = await _isarService.db;
    final all = await isar.settingsModels.where().findAll();
    return all.isEmpty ? null : all.first;
  }

  @override
  Future<void> save(SettingsModel settings) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.settingsModels.put(settings);
    });
  }
}
