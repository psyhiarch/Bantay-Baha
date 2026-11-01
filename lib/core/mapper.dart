
import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/data/models/telemetry_raw.dart';

import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/heatmap_point.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';
import 'package:bantay_baha/domain/models/weather.dart';

DateTime _parseDateTime(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    throw FormatException('$fieldName is missing');
  }

  final dateTime = DateTime.tryParse(value);

  if (dateTime == null) {
    throw FormatException('Invalid $fieldName: $value');
  }

  return dateTime;
}

extension FloodRawMapper on FloodRaw {
  Flood toDomain() {
    return Flood(
      success: success ?? false,
      calculatedAt: _parseDateTime(
        calculatedAt,
        'calculatedAt',
      ),
      scrapedAt: _parseDateTime(
        scrapedAt,
        'scrapedAt',
      ),
      metrics: Metrics.fromJson(metrics ?? {}),
      stations: stations
              ?.map((item) => Station.fromJson(item))
              .toList() ??
          [],
      roads: roads
              ?.map((item) => Road.fromJson(item))
              .toList() ??
          [],
      heatmapPoints: heatmapPoints
              ?.map((item) => HeatmapPoint.fromJson(item))
              .toList() ??
          [],
      weather: Weather.fromJson(weather ?? {}),
    );
  }
}

extension TelemetryRawMapper on TelemetryRaw {
  Telemetry toDomain() {
    return Telemetry(
      success: success ?? false,
      scrapedAt: _parseDateTime(
        scrapedAt,
        'scrapedAt',
      ),
      cachedAt: _parseDateTime(
        cachedAt,
        'cachedAt',
      ),
      metrics: Metrics.fromJson(metrics ?? {}),
      stations: stations
              ?.map((item) => Station.fromJson(item))
              .toList() ??
          [],
    );
  }
}
