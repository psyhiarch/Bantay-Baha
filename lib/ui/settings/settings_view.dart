import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/data/services/background_service.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/ui/theme/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final LocalNotificationService _notifications =
      getIt<LocalNotificationService>();
  bool _enabled = false;
  bool _loading = true;
  int _watchThreshold = 2;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await _notifications.notificationsEnabled();
    final threshold = await _notifications.watchAlertThreshold();
    if (!mounted) return;
    setState(() {
      _enabled = enabled;
      _watchThreshold = threshold;
      _loading = false;
    });
  }

  Future<void> _setEnabled(bool enabled) async {
    if (enabled) {
      late final bool granted;
      try {
        granted = await _notifications.enableNotifications();
      } on PlatformException {
        if (mounted) _showPermissionHint();
        return;
      }
      if (mounted) setState(() => _enabled = granted);
      if (granted) await schedulePeriodicTask();
      if (!granted && mounted) _showPermissionHint();
      return;
    }

    await _notifications.disableNotifications();
    if (mounted) setState(() => _enabled = false);
    await cancelRecurringJob();
  }

  void _showPermissionHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Allow notifications in your device settings.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<AppThemeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Appearance'),
            subtitle: const Text('Choose your app theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeController.themeMode,
              onChanged: (mode) {
                if (mode != null) themeController.setThemeMode(mode);
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Flood notifications'),
            subtitle: const Text('Early warnings and new advisories'),
            value: _enabled,
            onChanged: _loading ? null : _setEnabled,
          ),
          ListTile(
            leading: const Icon(Icons.warning_amber_rounded),
            title: const Text('Watched station alert level'),
            subtitle: const Text(
              'Notify when a watched station reaches this risk level',
            ),
            trailing: DropdownButton<int>(
              value: _watchThreshold,
              onChanged: _loading
                  ? null
                  : (value) async {
                      if (value == null) return;
                      await _notifications.setWatchAlertThreshold(value);
                      if (mounted) setState(() => _watchThreshold = value);
                    },
              items: const [
                DropdownMenuItem(value: 1, child: Text('Warning')),
                DropdownMenuItem(value: 2, child: Text('Alarm')),
                DropdownMenuItem(value: 3, child: Text('Critical')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
