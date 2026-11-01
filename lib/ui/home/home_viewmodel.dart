import 'dart:collection';

import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final FloodRepository _floodRepository;
  Flood? _flood;
  List<Station> _stations = [];
  UnmodifiableListView<Station> get stations => UnmodifiableListView(_stations);
  Metrics? _metrics;
  Metrics? get metrics => _metrics;
  Telemetry? _telemetry;
  Telemetry? get telemetry => _telemetry;

  HomeViewModel(this._floodRepository);

  Future<void> init() async {
    _flood = await _floodRepository.getFloodLive();
    _metrics = _flood?.metrics;
    _telemetry = await _floodRepository.getTelemetry();
    notifyListeners();
  }
}
