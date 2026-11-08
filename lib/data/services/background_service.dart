import 'dart:developer';

import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const String periodicTask = 'flood-alert';
const String floodAlertTask = 'FloodAlert';
const Duration floodAlertFrequency = Duration(minutes: 15);

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

bool get isBackgroundAlertsSupported =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

@pragma('vm:entry-point')
void callbackDispatcher() {
  setupLocator();
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task != floodAlertTask && task != periodicTask) return false;
      final notificationService = LocalNotificationService(
        plugin: notifications,
      );
      await notificationService.initialize();
      await checkFloodAlerts(notificationService: notificationService);
      return true;
    } catch (e, stackTrace) {
      log(
        'Background flood alert task failed',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  });
}

Future<void> checkFloodAlerts({
  LocalNotificationService? notificationService,
}) async {
  final prefs = await SharedPreferences.getInstance();
  if (!(prefs.getBool('notifications_enabled') ?? false)) return;

  final floodRepository = getIt<FloodRepository>();
  final flood = await floodRepository.getFloodLive();
  Object? failure;
  final service =
      notificationService ?? LocalNotificationService(plugin: notifications);

  if (flood == null) {
    failure = StateError('Flood data unavailable.');
  } else if (!floodRepository.isUsingCachedFloodData) {
    await service.notifyCurrentFloodRisks(flood.stations);
    await service.notifyWatchedStationChanges(flood.stations);
  }

  final advisories = await floodRepository.getAdvisories();
  if (advisories == null) {
    failure ??= StateError('Advisories unavailable.');
  } else if (!floodRepository.isUsingCachedAdvisories) {
    await service.notifyNewAdvisories(advisories);
  }

  if (failure != null) throw failure;
}

Future<void> initializeBackgroundAlerts() async {
  if (!isBackgroundAlertsSupported) return;
  await Workmanager().initialize(callbackDispatcher);
}

Future<void> schedulePeriodicTask() async {
  if (!isBackgroundAlertsSupported) return;
  await Workmanager().registerPeriodicTask(
    periodicTask,
    floodAlertTask,
    frequency: floodAlertFrequency,
    existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    constraints: Constraints(networkType: NetworkType.connected),
  );
}

Future<void> cancelRecurringJob() async {
  if (!isBackgroundAlertsSupported) return;
  await Workmanager().cancelByUniqueName(periodicTask);
}
