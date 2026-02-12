import '../../models/settings_model.dart';

abstract class SettingsRepository {
  Stream<SettingsModel?> watch();
  Future<SettingsModel?> fetch();
  Future<void> save(SettingsModel settings);
}
