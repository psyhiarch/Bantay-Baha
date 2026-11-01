// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heatmap_point_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeatmapPointRaw _$HeatmapPointRawFromJson(Map<String, dynamic> json) =>
    _HeatmapPointRaw(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      intensity: (json['intensity'] as num).toDouble(),
      depthCm: (json['depthCm'] as num).toDouble(),
      category: json['category'] as String,
      radius: (json['radius'] as num).toDouble(),
      isFlooded: json['isFlooded'] as bool,
    );

Map<String, dynamic> _$HeatmapPointRawToJson(_HeatmapPointRaw instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'intensity': instance.intensity,
      'depthCm': instance.depthCm,
      'category': instance.category,
      'radius': instance.radius,
      'isFlooded': instance.isFlooded,
    };
