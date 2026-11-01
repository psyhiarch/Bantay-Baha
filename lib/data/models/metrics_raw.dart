
import 'package:freezed_annotation/freezed_annotation.dart';

part 'metrics_raw.freezed.dart';

part 'metrics_raw.g.dart';

@freezed
abstract class MetricsRaw with _$MetricsRaw{

  const factory MetricsRaw({
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
  }) = _MetricsRaw;

  factory MetricsRaw.fromJson(Map<String, dynamic> json) => _$MetricsRawFromJson(json);
}
