// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_pin_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationPinRaw _$LocationPinRawFromJson(Map<String, dynamic> json) =>
    _LocationPinRaw(
      id: json['id'] as String,
      road: json['road'] as String,
      landmark: json['landmark'] as String,
      coordinates: json['coordinates'] as Map<String, dynamic>,
      depthCategory: json['depthCategory'] as String,
      passability: json['passability'] as String,
      severity: json['severity'],
    );

Map<String, dynamic> _$LocationPinRawToJson(_LocationPinRaw instance) =>
    <String, dynamic>{
      'id': instance.id,
      'road': instance.road,
      'landmark': instance.landmark,
      'coordinates': instance.coordinates,
      'depthCategory': instance.depthCategory,
      'passability': instance.passability,
      'severity': instance.severity,
    };
