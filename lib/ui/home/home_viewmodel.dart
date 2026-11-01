import 'dart:collection';

import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final FloodRepository _floodRepository;

  HomeViewModel(this._floodRepository);

  Flood? _flood;
  Telemetry? _telemetry;
  Metrics? _metrics;

  final List<Station> _stations = [];

  late final UnmodifiableListView<Station> _stationsView = UnmodifiableListView(
    _stations,
  );

  bool _isLoading = false;

  String? _floodError;
  String? _telemetryError;

  Flood? get flood => _flood;
  Telemetry? get telemetry => _telemetry;
  Metrics? get metrics => _metrics;

  UnmodifiableListView<Station> get stations => _stationsView;

  bool get isLoading => _isLoading;

  String? get floodError => _floodError;
  String? get telemetryError => _telemetryError;

  bool get hasFloodError => _floodError != null;
  bool get hasTelemetryError => _telemetryError != null;

  Future<void> init() async {
    _isLoading = true;

    _floodError = null;
    _telemetryError = null;

    notifyListeners();

    try {
      await Future.wait([_loadFlood(), _loadTelemetry()]);
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
      _metrics = result.metrics;

      _stations
        ..clear()
        ..addAll(result.stations);

      _floodError = null;
    } catch (error, stackTrace) {
      debugPrint('Flood loading error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _floodError = 'Unable to load flood data.';
    } finally {
      notifyListeners();
    }
  }

  Future<void> _loadTelemetry() async {
    try {
      final result = await _floodRepository.getTelemetry();

      if (result == null) {
        throw Exception('Telemetry data is unavailable.');
      }

      _telemetry = result;
      _telemetryError = null;
    } catch (error, stackTrace) {
      debugPrint('Telemetry loading error: $error');
      debugPrintStack(stackTrace: stackTrace);

      _telemetryError = 'Unable to load telemetry data.';
    } finally {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await init();
  }
}
