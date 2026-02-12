import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../../core/providers.dart';
import '../../../models/daily_stats_model.dart';
import '../../../models/level_model.dart';
import '../../../models/settings_model.dart';
import '../../../models/streak_model.dart';
import '../../../models/sync_queue_item.dart';
import '../../../models/task_model.dart';
import '../../../theme/app_colors.dart';
import '../application/settings_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _urlController = TextEditingController();
  final _anonController = TextEditingController();

  bool _syncEnabled = true;
  bool _graceDayEnabled = true;
  int _graceDaysPer30 = 1;

  bool _isValidSupabaseConfig(String url, String anonKey) {
    final uri = Uri.tryParse(url);
    final hasValidScheme = uri != null && (uri.scheme == 'https' || uri.scheme == 'http');
    return hasValidScheme && anonKey.isNotEmpty;
  }

  @override
  void dispose() {
    _urlController.dispose();
    _anonController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final controller = ref.read(settingsControllerProvider);
    final settings = await controller.loadOrDefault();
    if (!mounted) {
      return;
    }
    setState(() {
      _syncEnabled = settings.syncEnabled;
      _urlController.text = settings.supabaseUrl;
      _anonController.text = settings.supabaseAnonKey;
      _graceDayEnabled = settings.graceDayEnabled;
      _graceDaysPer30 = settings.graceDaysPer30;
    });
  }

  Future<void> _saveSettings() async {
    final url = _urlController.text.trim();
    final key = _anonController.text.trim();
    final valid = _isValidSupabaseConfig(url, key);

    final effectiveSync = _syncEnabled && valid;
    final controller = ref.read(settingsControllerProvider);
    await controller.save(
      SettingsModel(
        syncEnabled: effectiveSync,
        supabaseUrl: url,
        supabaseAnonKey: key,
        graceDayEnabled: _graceDayEnabled,
        graceDaysPer30: _graceDaysPer30,
      ),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          effectiveSync
              ? 'Settings saved.'
              : 'Settings saved. Sync disabled due to invalid Supabase configuration.',
        ),
      ),
    );
  }

  Future<void> _testSyncConnection() async {
    final url = _urlController.text.trim();
    final key = _anonController.text.trim();
    if (!_isValidSupabaseConfig(url, key)) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Supabase URL or anon key.')),
      );
      return;
    }

    final client = ref.read(supabaseClientProvider).client;
    if (client == null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Supabase client is not initialized from .env. Save config and restart app.'),
        ),
      );
      return;
    }

    try {
      await client.from('tasks').select('id').limit(1);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync test succeeded.')),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync test failed. Check URL/key and schema permissions.')),
      );
    }
  }

  Future<void> _exportData() async {
    final isar = await ref.read(isarServiceProvider).db;
    final tasks = await isar.taskModels.where().findAll();
    final payload = {
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
    final jsonString = const JsonEncoder.withIndent('  ').convert(payload);

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export JSON'),
        content: SizedBox(
          width: 480,
          child: SelectableText(jsonString),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _importData() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import JSON'),
        content: SizedBox(
          width: 480,
          child: TextField(
            controller: controller,
            maxLines: 12,
            decoration: const InputDecoration(hintText: 'Paste JSON here'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (result == null || result.isEmpty) {
      return;
    }

    final payload = jsonDecode(result) as Map<String, dynamic>;
    final tasks = (payload['tasks'] as List<dynamic>?) ?? [];
    final isar = await ref.read(isarServiceProvider).db;

    await isar.writeTxn(() async {
      await isar.taskModels.clear();
      for (final entry in tasks) {
        await isar.taskModels.put(
          TaskModel.fromJson(
            Map<String, dynamic>.from(entry as Map<Object?, Object?>),
          ),
        );
      }
    });
  }

  Future<void> _resetData() async {
    final isar = await ref.read(isarServiceProvider).db;
    await isar.writeTxn(() async {
      await isar.taskModels.clear();
      await isar.dailyStatsModels.clear();
      await isar.levelModels.clear();
      await isar.streakModels.clear();
      await isar.syncQueueItems.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text('Settings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sync', style: TextStyle(fontSize: 18)),
                    SwitchListTile(
                      value: _syncEnabled,
                      onChanged: (value) => setState(() => _syncEnabled = value),
                      title: const Text('Enable Supabase Sync'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(labelText: 'Supabase URL'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _anonController,
                      decoration: const InputDecoration(labelText: 'Supabase Anon Key'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _saveSettings,
                      child: const Text('Save Settings'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _testSyncConnection,
                      child: const Text('Test Sync Connection'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Streak Rules', style: TextStyle(fontSize: 18)),
                    SwitchListTile(
                      value: _graceDayEnabled,
                      onChanged: (value) => setState(() => _graceDayEnabled = value),
                      title: const Text('Enable grace days'),
                    ),
                    Row(
                      children: [
                        const Text('Grace days per 30 days'),
                        const Spacer(),
                        DropdownButton<int>(
                          value: _graceDaysPer30,
                          dropdownColor: AppColors.surface,
                          items: [1, 2, 3]
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() => _graceDaysPer30 = value ?? 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: _exportData,
                          child: const Text('Export JSON'),
                        ),
                        OutlinedButton(
                          onPressed: _importData,
                          child: const Text('Import JSON'),
                        ),
                        FilledButton(
                          onPressed: _resetData,
                          style: FilledButton.styleFrom(backgroundColor: AppColors.accentSecondary),
                          child: const Text('Reset All Data'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
