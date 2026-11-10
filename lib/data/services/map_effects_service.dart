import 'package:shared_preferences/shared_preferences.dart';

enum MapEffectMode { staticMode, gentlePulse }

class MapEffectsService {
  static const _preferenceKey = 'map_effect_mode';

  Future<MapEffectMode> load() async {
    final preferences = await SharedPreferences.getInstance();
    return switch (preferences.getString(_preferenceKey)) {
      'gentlePulse' => MapEffectMode.gentlePulse,
      _ => MapEffectMode.staticMode,
    };
  }

  Future<void> save(MapEffectMode mode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, switch (mode) {
      MapEffectMode.staticMode => 'static',
      MapEffectMode.gentlePulse => 'gentlePulse',
    });
  }
}
