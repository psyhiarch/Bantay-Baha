import 'dart:developer';

import 'package:bantay_baha/core/mapper.dart';
import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/data/models/telemetry_raw.dart';
import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';

class FloodRepositoryImpl implements FloodRepository {
  final FloodApiService _floodApiService;

  const FloodRepositoryImpl(this._floodApiService);

  @override
  Future<Flood?> getFloodLive() async {
    try {
      final FloodRaw floodRaw = await _floodApiService.fetchFloodLive();
      final Flood flood = floodRaw.toDomain();
      return flood;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  @override
  Future<Telemetry?> getTelemetry() async {
    try {
      final TelemetryRaw telemetryRaw = await _floodApiService.fetchTelemetry();
      final Telemetry telemetry = telemetryRaw.toDomain();
      return telemetry;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
