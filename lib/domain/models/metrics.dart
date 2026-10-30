
import 'package:freezed_annotation/freezed_annotation.dart';

part 'metrics.freezed.dart';

@freezed
abstract class Metrics with _$Metrics{

  const factory Metrics({
    required int totalStations,
    required int highRiskStationsCount,
    required double peakWaterLevel,
    required String peakWaterStation,
    required double maxRain1h,
    required double maxRain24h,
  }) = _Metrics;
}
