import 'dart:convert';

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
  static const _watchedStationsKey = 'watched_station_ids';
  static const _watchThresholdKey = 'watch_alert_threshold';
  static const _watchLevelsKey = 'watched_station_risk_levels';
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

  Future<void> setStationWatched(String stationId, bool watched) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = (prefs.getStringList(_watchedStationsKey) ?? <String>[])
        .toSet();
    if (watched) {
      ids.add(stationId);
    } else {
      ids.remove(stationId);
      final levels = prefs.getString(_watchLevelsKey);
      if (levels != null) {
        try {
          final map = Map<String, dynamic>.from(jsonDecode(levels) as Map);
          map.remove(stationId);
          await prefs.setString(_watchLevelsKey, jsonEncode(map));
        } catch (_) {}
      }
    }
    await prefs.setStringList(_watchedStationsKey, ids.toList());
  }

  Future<int> watchAlertThreshold() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_watchThresholdKey) ?? 2;
  }

  Future<void> setWatchAlertThreshold(int threshold) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_watchThresholdKey, threshold.clamp(1, 3).toInt());
  }

  Future<void> notifyWatchedStationChanges(Iterable<Station> stations) async {
    final prefs = await SharedPreferences.getInstance();
    final watched =
        (prefs.getStringList(_watchedStationsKey) ?? const <String>[]).toSet();
    if (watched.isEmpty) return;
    Map<String, dynamic> previous;
    try {
      previous = Map<String, dynamic>.from(
        jsonDecode(prefs.getString(_watchLevelsKey) ?? '{}') as Map,
      );
    } catch (_) {
      previous = {};
    }
    final current = <String, String>{};
    final threshold = prefs.getInt(_watchThresholdKey) ?? 2;
    for (final station in stations.where(
      (item) => watched.contains(item.stationId),
    )) {
      final level = station.riskLevel.toUpperCase();
      current[station.stationId] = level;
      final rank = _riskRank(level);
      final oldRank = _riskRank(
        previous[station.stationId]?.toString() ?? 'NORMAL',
      );
      if (oldRank < threshold &&
          rank >= threshold &&
          (prefs.getBool('notifications_enabled') ?? false)) {
        await _show(
          id: 'watched:${station.stationId}:$level'.hashCode,
          title: '${station.stationName} is at $level risk',
          body:
              'Water level is ${station.waterLevel.toStringAsFixed(2)} m. Check the station map for details.',
        );
      }
    }
    await prefs.setString(
      _watchLevelsKey,
      jsonEncode({...previous, ...current}),
    );
  }

  int _riskRank(String level) {
    final value = level.toLowerCase();
    if (value.contains('critical') || value.contains('severe')) return 3;
    if (value.contains('alarm') || value.contains('high')) return 2;
    if (value.contains('warning') || value.contains('moderate')) return 1;
    return 0;
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

  Future<Set<String>> watchedStationIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_watchedStationsKey) ?? const <String>[])
        .toSet();
  }
}
