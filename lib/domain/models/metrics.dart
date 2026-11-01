
import 'package:freezed_annotation/freezed_annotation.dart';

part 'metrics.freezed.dart';

@freezed
abstract class Metrics with _$Metrics{

  const factory Metrics({
    required int totalStations,
    required int highRiskStationsCount,
    required double peakWaterLevel,
    required String peakWaterStation,
    required String peakWaterStationId,
    required double maxRain1h,
    required String maxRain1hStation,
    required String maxRain1hStationId,
    required double maxRain24h,
    required String maxRain24hStation,
    required String maxRain24hStationId,
  }) = _Metrics;

}
