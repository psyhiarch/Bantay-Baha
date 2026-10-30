

import 'package:freezed_annotation/freezed_annotation.dart';

part 'station.freezed.dart';

@freezed
abstract class Station with _$Station {


  const factory Station({
   required String stationId,
  required String stationName,
  required double latitude,
  required double longitude,
  required double rain10min,
  required double rain1h,
  required double rain3h,
  required double rain24h,
  required double waterLevel,
  required String riskLevel,
  required double temperatureC,
  required double heatIndexC,
  required double humidityPercent,
  }) = _Station;
}
