

import 'package:bantay_baha/domain/models/heatmap_point.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/weather.dart';

class Flood {
  final bool success;
  final DateTime calculatedAt;
  final DateTime scrapedAt;
  final Metrics metrics;
  final List<Station> stations;
  final List<Road> roads;
  final List<HeatmapPoint> heatmapPoints;
  final Weather weather;

  const Flood({
    required this.success,
    required this.calculatedAt,
    required this.scrapedAt,
    required this.metrics,
    required this.stations,
    required this.roads,
    required this.heatmapPoints,
    required this.weather,
  });

}
