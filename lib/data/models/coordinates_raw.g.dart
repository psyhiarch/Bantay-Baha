// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoordinatesRaw _$CoordinatesRawFromJson(Map<String, dynamic> json) =>
    _CoordinatesRaw(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesRawToJson(_CoordinatesRaw instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};
