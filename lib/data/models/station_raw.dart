import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_raw.freezed.dart';

part 'station_raw.g.dart';

@freezed
abstract class StationRaw with _$StationRaw {
  const factory StationRaw({
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
    required String lastUpdated,
  }) = _StationRaw;

  factory StationRaw.fromJson(Map<String, dynamic> json) =>
      _$StationRawFromJson(json);
}
