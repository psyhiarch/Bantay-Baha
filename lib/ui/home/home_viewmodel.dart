import 'dart:async';
import 'dart:collection';

import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/data/services/station_history_service.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final FloodRepository _floodRepository;
  final LocalNotificationService _notificationService;
  final StationHistoryService _stationHistoryService;

  HomeViewModel({
    required this._floodRepository,
    required this._notificationService,
    required this._stationHistoryService,
  });

  Flood? _flood;
  List<Advisory> _advisories = const [];
  bool _isLoadingAdvisories = false;
  String? _advisoriesError;
  Metrics? _metrics;
  final List<Station> _stations = [];
  Map<String, List<StationReading>> _stationHistory = {};
  Set<String> _watchedStationIds = {};
  Set<String> get watchedStationIds => Set.unmodifiable(_watchedStationIds);
  bool isStationWatched(String stationId) =>
      _watchedStationIds.contains(stationId);

  Future<void> toggleStationWatch(String stationId) async {
    final watched = !_watchedStationIds.contains(stationId);
    if (watched) {
      _watchedStationIds = {..._watchedStationIds, stationId};
    } else {
      _watchedStationIds = {..._watchedStationIds}..remove(stationId);
    }
    notifyListeners();
    await _notificationService.setStationWatched(stationId, watched);
  }

  late final UnmodifiableListView<Station> _stationsView = UnmodifiableListView(
    _stations,
  );
  Flood? get flood => _flood;
  List<Advisory> get advisories => List.unmodifiable(_advisories);
  bool get isLoadingAdvisories => _isLoadingAdvisories;
  String? get advisoriesError => _advisoriesError;
  bool get isUsingCachedFloodData => _floodRepository.isUsingCachedFloodData;
  bool get isUsingCachedAdvisories => _floodRepository.isUsingCachedAdvisories;
  DateTime? get floodCacheSavedAt => _floodRepository.floodCacheSavedAt;
  DateTime? get advisoriesCacheSavedAt =>
      _floodRepository.advisoriesCacheSavedAt;
  Metrics? get metrics => _metrics;
  UnmodifiableListView<Station> get stations => _stationsView;
  List<StationReading> historyFor(String stationId) =>
      List.unmodifiable(_stationHistory[stationId] ?? const []);

  bool _isLoading = false;
  Timer? _refreshTimer;
  String? _floodError;
  bool get isLoading => _isLoading;
  String? get floodError => _floodError;
  bool get hasFloodError => _floodError != null;

  Future<void> init() async {
    _refreshTimer ??= Timer.periodic(
      const Duration(minutes: 5),
      (_) => _refreshAll(),
    );
    if (_isLoading) return;
    _watchedStationIds = await _notificationService.watchedStationIds();
    _isLoading = true;

    _floodError = null;

    notifyListeners();

    try {
      await Future.wait([_loadFlood(), loadAdvisories(force: true)]);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadFlood() async {
    try {
      final result = await _floodRepository.getFloodLive();

      if (result == null) {
        throw Exception('Flood data is unavailable.');
      }

      _flood = result;

      _stations
        ..clear()
        ..addAll(result.stations);
      _metrics = result.metrics;
      if (!_floodRepository.isUsingCachedFloodData) {
        //await _notificationService.notifyWatchedStationChanges(result.stations);
        try {
          _stationHistory = await _stationHistoryService.record(
            result.stations,
            result.calculatedAt,
          );
        } catch (error) {
          debugPrint('Station history could not be saved: $error');
        }

        // for (final station in result.stations) {
        //   final level = station.riskLevel.toLowerCase();
        //   if (level.contains('high') ||
        //       level.contains('severe') ||
        //       level.contains('critical')) {
        //     await _notificationService.notifyEarlyWarning(
        //       stationId: station.stationId,
        //       stationName: station.stationName,
        //       riskLevel: station.riskLevel,
        //       waterLevel: station.waterLevel,
        //     );
        //   }
        // }
      }

      _floodError = null;
    } catch (error, stackTrace) {
      debugPrint('Flood loading error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _floodError = 'Unable to load flood data.';
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await init();
  }

  Future<void> _refreshAll() async {
    await Future.wait([refresh(), loadAdvisories(force: true)]);
  }

  Future<void> loadAdvisories({bool force = false}) async {
    if (_isLoadingAdvisories) return;
    if (_advisories.isNotEmpty && !force) return;
    _isLoadingAdvisories = true;
    _advisoriesError = null;
    notifyListeners();
    try {
      final result = await _floodRepository.getAdvisories();
      if (result == null) throw Exception('Advisories are unavailable.');
      // if (!_floodRepository.isUsingCachedAdvisories) {
      //   await _notificationService.notifyNewAdvisories(result);
      // }
      _advisories = result;
    } catch (error) {
      debugPrint('Advisory loading error: $error');
      _advisoriesError = 'Unable to load advisories.';
    } finally {
      _isLoadingAdvisories = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
