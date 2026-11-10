import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/station.dart';

class LocalNotificationService {
  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  static const _seenAdvisoryIdsKey = 'seen_advisory_ids';
  static const _seenWarningLevelsKey = 'seen_warning_levels';
  static const _advisoriesInitializedKey = 'advisories_initialized';
  static const _warningChannel = AndroidNotificationChannel(
    'early_warnings',
    'Early warnings',
    description: 'Flood and heavy rain early warnings',
    importance: Importance.max,
  );

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(settings: settings);
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(_warningChannel);
  }

  Future<bool> notificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? false;
  }

  Future<bool> enableNotifications() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final granted =
        await android?.requestNotificationsPermission() ??
        await ios?.requestPermissions(alert: true, badge: true, sound: true) ??
        false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', granted);
    return granted;
  }

  Future<void> disableNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', false);
  }

  Future<void> notifyCurrentFloodRisks(Iterable<Station> stations) async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('notifications_enabled') ?? false)) return;

    for (final station in stations) {
      final level = station.riskLevel.toLowerCase();
      final isDangerous =
          level.contains('high') ||
          level.contains('severe') ||
          level.contains('critical');
      if (!isDangerous) continue;

      await _show(
        id: 'flood:${station.stationId}'.hashCode,
        title: 'Flood Warning: ${station.stationName}',
        body:
            '${station.riskLevel} risk detected. Water level: ${station.waterLevel}',
      );
    }
  }

  Future<void> notifyEarlyWarning({
    required String stationId,
    required String stationName,
    required String riskLevel,
    required double waterLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('notifications_enabled') ?? false)) return;
    final seen = prefs.getStringList(_seenWarningLevelsKey) ?? <String>[];
    final key = '$stationId:${riskLevel.toLowerCase()}';
    if (seen.contains(key)) return;
    seen.add(key);
    await prefs.setStringList(_seenWarningLevelsKey, seen);
    await _show(
      id: key.hashCode,
      title: 'Flood early warning: $riskLevel',
      body:
          '$stationName reports a water level of ${waterLevel.toStringAsFixed(2)} m.',
    );
  }

  Future<void> notifyNewAdvisories(Iterable<Advisory> advisories) async {
    final prefs = await SharedPreferences.getInstance();
    final seen = (prefs.getStringList(_seenAdvisoryIdsKey) ?? <String>[])
        .toSet();
    final list = advisories.toList();
    if (!(prefs.getBool(_advisoriesInitializedKey) ?? false)) {
      await prefs.setStringList(
        _seenAdvisoryIdsKey,
        list.map((item) => item.id).toList(),
      );
      await prefs.setBool(_advisoriesInitializedKey, true);
      return;
    }
    final unseen = list.where((item) => !seen.contains(item.id)).toList();
    if (unseen.isEmpty) return;
    seen.addAll(unseen.map((item) => item.id));
    await prefs.setStringList(_seenAdvisoryIdsKey, seen.toList());
    if (!(prefs.getBool('notifications_enabled') ?? false)) return;
    // Notify once per refresh so a batch of new reports does not flood the user.
    final latest = unseen.first;
    final count = unseen.length;
    await _show(
      id: latest.id.hashCode,
      title: count == 1
          ? 'New flood update: ${latest.severity}'
          : '$count new flood updates',
      body: '${latest.road}, ${latest.city} · Open Advisories for details.',
    );
  }

  Future<void> _show({
    required int id,
    required String title,
    required String body,
  }) {
    return _plugin.show(
      id: id & 0x7fffffff,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'early_warnings',
          'Early warnings',
          channelDescription: 'Flood and heavy rain early warnings',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> requestPermission() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }
}
