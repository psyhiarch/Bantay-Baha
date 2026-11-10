import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/data/services/background_service.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/data/services/map_effects_service.dart';
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
  final MapEffectsService _mapEffects = MapEffectsService();
  bool _enabled = false;
  bool _loading = true;
  MapEffectMode _mapEffectMode = MapEffectMode.staticMode;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await _notifications.notificationsEnabled();
    final mapEffectMode = await _mapEffects.load();
    if (!mounted) return;
    setState(() {
      _enabled = enabled;
      _mapEffectMode = mapEffectMode;
      _loading = false;
    });
  }

  Future<void> _setMapEffectMode(MapEffectMode mode) async {
    try {
      await _mapEffects.save(mode);
      if (mounted) setState(() => _mapEffectMode = mode);
    } catch (error) {
      debugPrint('Unable to save map effect preference: $error');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save the map effect setting.')),
      );
    }
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
          ListTile(
            leading: const Icon(Icons.blur_on_outlined),
            title: const Text('Map effects'),
            subtitle: const Text(
              'Static is recommended for motion sensitivity',
            ),
            trailing: DropdownButton<MapEffectMode>(
              value: _mapEffectMode,
              onChanged: _loading
                  ? null
                  : (mode) {
                      if (mode != null) _setMapEffectMode(mode);
                    },
              items: const [
                DropdownMenuItem(
                  value: MapEffectMode.staticMode,
                  child: Text('Static'),
                ),
                DropdownMenuItem(
                  value: MapEffectMode.gentlePulse,
                  child: Text('Gentle pulse'),
                ),
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
        ],
      ),
    );
  }
}
