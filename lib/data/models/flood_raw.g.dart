// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flood_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FloodRaw _$FloodRawFromJson(Map<String, dynamic> json) => _FloodRaw(
  success: json['success'] as bool,
  calculatedAt: json['calculatedAt'] as String,
  scrapedAt: json['scrapedAt'] as String,
  metrics: json['metrics'] as Map<String, dynamic>,
  stations: (json['stations'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
  roads: (json['roads'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
  heatmapPoints: (json['heatmapPoints'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
  weather: json['weather'] as Map<String, dynamic>,
);

Map<String, dynamic> _$FloodRawToJson(_FloodRaw instance) => <String, dynamic>{
  'success': instance.success,
  'calculatedAt': instance.calculatedAt,
  'scrapedAt': instance.scrapedAt,
  'metrics': instance.metrics,
  'stations': instance.stations,
  'roads': instance.roads,
  'heatmapPoints': instance.heatmapPoints,
  'weather': instance.weather,
};
