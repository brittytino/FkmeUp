import '../../models/settings_model.dart';
import '../local/settings_local_data_source.dart';
import 'settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  Stream<SettingsModel?> watch() {
    return _local.watch();
  }

  @override
  Future<SettingsModel?> fetch() {
    return _local.fetch();
  }

  @override
  Future<void> save(SettingsModel settings) {
    return _local.save(settings);
  }
}
