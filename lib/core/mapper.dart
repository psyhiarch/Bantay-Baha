import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/heatmap_point.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/weather.dart';

extension FloodRawMapper on FloodRaw {
  Flood? toDomain() {
    try {
      final DateTime calculatedAtDt = DateTime.tryParse(calculatedAt ?? '') ?? DateTime.now();
      final DateTime scrapedAtDt = DateTime.tryParse(scrapedAt ?? '') ?? DateTime.now();
      final List<Station> stationL = stations
          ?.map((i) => Station.fromJson(i))
          .toList() ?? [];
      final List<Road> roadL = roads?.map((i) => Road.fromJson(i)).toList() ?? [];
      final List<HeatmapPoint> heatmapPointL = heatmapPoints
          ?.map((i) => HeatmapPoint.fromJson(i))
          .toList() ?? [];
      return Flood(
        success: success ?? false,
        calculatedAt: calculatedAtDt,
        scrapedAt: scrapedAtDt,
        metrics: Metrics.fromJson(metrics ?? {}),
        stations: stationL,
        roads: roadL,
        heatmapPoints: heatmapPointL,
        weather: Weather.fromJson(weather ?? {}),
      );
    } catch (e) {
      return null;
    }
  }
}
