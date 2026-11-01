// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherRaw _$WeatherRawFromJson(Map<String, dynamic> json) => _WeatherRaw(
  metroManilaRainMmHr: (json['metroManilaRainMmHr'] as num).toDouble(),
  metroManilaRain24hMm: (json['metroManilaRain24hMm'] as num).toDouble(),
  forecast3hTotalMm: (json['forecast3hTotalMm'] as num).toDouble(),
  trend: json['trend'] as String,
  conditionLabel: json['conditionLabel'] as String,
);

Map<String, dynamic> _$WeatherRawToJson(_WeatherRaw instance) =>
    <String, dynamic>{
      'metroManilaRainMmHr': instance.metroManilaRainMmHr,
      'metroManilaRain24hMm': instance.metroManilaRain24hMm,
      'forecast3hTotalMm': instance.forecast3hTotalMm,
      'trend': instance.trend,
      'conditionLabel': instance.conditionLabel,
    };
