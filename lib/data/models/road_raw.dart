


import 'package:freezed_annotation/freezed_annotation.dart';

part 'road_raw.freezed.dart';
part 'road_raw.g.dart';

@freezed
abstract class RoadRaw with _$RoadRaw{

  const factory RoadRaw({
    required String roadId,
    required String roadName,
    required List<List<double>> coordinates,
    required List<double> centroid,
    required double elevationM,
    required double elevationMeters,
    required double noahHazardLevel,
    required bool isFlooded,
    required double estimatedDepthCm,
    required double hazardScore,
    required String severity,
    required String color,
    required String depthCategory,
    required lineWeight,
    required List<String> drivableVehicles,
    required Map<String, dynamic> nearestStation,
    required bool isNearRiver,
    required String nationalRoute,
    required String roadClassification,
    required String region,
    required String description,
  }) = _RoadRaw;

  factory RoadRaw.fromJson(Map<String, dynamic> json) => _$RoadRawFromJson(json);
}
