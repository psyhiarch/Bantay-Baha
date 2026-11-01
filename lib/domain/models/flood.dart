

import 'package:bantay_baha/domain/models/heatmap_point.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flood.freezed.dart';

@freezed
abstract class Flood with _$Flood {

  const Flood._();

  const factory Flood({
    required bool success,
    required DateTime calculatedAt,
    required DateTime scrapedAt,
    required Metrics metrics,
    required List<Station> stations,
    required List<Road> roads,
    required List<HeatmapPoint> heatmapPoints,
    required Weather weather,
  }) = _Flood;

}
