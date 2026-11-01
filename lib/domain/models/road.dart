

import 'package:freezed_annotation/freezed_annotation.dart';

part 'road.freezed.dart';
part 'road.g.dart';

@freezed
abstract class Road with _$Road{

  const factory Road({
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
  }) = _Road;

  factory Road.fromJson(Map<String, dynamic> json) => _$RoadFromJson(json);
}
