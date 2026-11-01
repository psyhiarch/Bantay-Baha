// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'road_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoadRaw _$RoadRawFromJson(Map<String, dynamic> json) => _RoadRaw(
  roadId: json['roadId'] as String,
  roadName: json['roadName'] as String,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
  centroid: (json['centroid'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  elevationM: (json['elevationM'] as num).toDouble(),
  elevationMeters: (json['elevationMeters'] as num).toDouble(),
  noahHazardLevel: (json['noahHazardLevel'] as num).toDouble(),
  isFlooded: json['isFlooded'] as bool,
  estimatedDepthCm: (json['estimatedDepthCm'] as num).toDouble(),
  hazardScore: (json['hazardScore'] as num).toDouble(),
  severity: json['severity'] as String,
  color: json['color'] as String,
  depthCategory: json['depthCategory'] as String,
  lineWeight: json['lineWeight'],
  drivableVehicles: (json['drivableVehicles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  nearestStation: json['nearestStation'] as Map<String, dynamic>,
  isNearRiver: json['isNearRiver'] as bool,
  nationalRoute: json['nationalRoute'] as String,
  roadClassification: json['roadClassification'] as String,
  region: json['region'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$RoadRawToJson(_RoadRaw instance) => <String, dynamic>{
  'roadId': instance.roadId,
  'roadName': instance.roadName,
  'coordinates': instance.coordinates,
  'centroid': instance.centroid,
  'elevationM': instance.elevationM,
  'elevationMeters': instance.elevationMeters,
  'noahHazardLevel': instance.noahHazardLevel,
  'isFlooded': instance.isFlooded,
  'estimatedDepthCm': instance.estimatedDepthCm,
  'hazardScore': instance.hazardScore,
  'severity': instance.severity,
  'color': instance.color,
  'depthCategory': instance.depthCategory,
  'lineWeight': instance.lineWeight,
  'drivableVehicles': instance.drivableVehicles,
  'nearestStation': instance.nearestStation,
  'isNearRiver': instance.isNearRiver,
  'nationalRoute': instance.nationalRoute,
  'roadClassification': instance.roadClassification,
  'region': instance.region,
  'description': instance.description,
};
