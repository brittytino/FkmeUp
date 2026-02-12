import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../models/settings_model.dart';

final settingsProvider = StreamProvider<SettingsModel?>((ref) {
  return ref.read(settingsRepositoryProvider).watch();
});

final settingsControllerProvider = Provider<SettingsController>((ref) {
  return SettingsController(ref.read(settingsRepositoryProvider));
});

class SettingsController {
  SettingsController(this._repository);

  final SettingsRepository _repository;

  Future<SettingsModel> loadOrDefault() async {
    final stored = await _repository.fetch();
    return stored ?? defaultSettings();
  }

  Future<void> save(SettingsModel settings) async {
    await _repository.save(settings);
  }
}

SettingsModel defaultSettings() {
  return SettingsModel(
    syncEnabled: true,
    supabaseUrl: '',
    supabaseAnonKey: '',
    graceDayEnabled: true,
    graceDaysPer30: 1,
  );
}
