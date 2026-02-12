import 'package:isar_community/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  SettingsModel({
    required this.syncEnabled,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.graceDayEnabled,
    required this.graceDaysPer30,
  });

  Id id = Isar.autoIncrement;

  late bool syncEnabled;
  late String supabaseUrl;
  late String supabaseAnonKey;
  late bool graceDayEnabled;
  late int graceDaysPer30;

  Map<String, dynamic> toJson() {
    return {
      'sync_enabled': syncEnabled,
      'supabase_url': supabaseUrl,
      'supabase_anon_key': supabaseAnonKey,
      'grace_day_enabled': graceDayEnabled,
      'grace_days_per_30': graceDaysPer30,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      syncEnabled: json['sync_enabled'] as bool,
      supabaseUrl: json['supabase_url'] as String,
      supabaseAnonKey: json['supabase_anon_key'] as String,
      graceDayEnabled: json['grace_day_enabled'] as bool,
      graceDaysPer30: json['grace_days_per_30'] as int,
    );
  }
}
