

import 'package:freezed_annotation/freezed_annotation.dart';

part 'station.freezed.dart';

part 'station.g.dart';

@freezed
abstract class Station with _$Station {


  const factory Station({
   required String stationId,
  required String stationName,
  required double latitude,
  required double longitude,
  required String geohash,
  required double rain10m,
  required double rain1h,
  required double rain24h,
  required double waterLevel,
  required double waterLevelDelta1h,
  required String waterRiskLevel,
  required String rainRiskLevel,
  required String riskLevel,
  required DateTime lastUpdated,
  }) = _Station;


  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
}
