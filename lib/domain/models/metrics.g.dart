// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Metrics _$MetricsFromJson(Map<String, dynamic> json) => _Metrics(
  totalStations: (json['totalStations'] as num).toInt(),
  highRiskStationsCount: (json['highRiskStationsCount'] as num).toInt(),
  peakWaterLevel: (json['peakWaterLevel'] as num).toDouble(),
  peakWaterStation: json['peakWaterStation'] as String,
  maxRain1h: (json['maxRain1h'] as num).toDouble(),
  maxRain24h: (json['maxRain24h'] as num).toDouble(),
);

Map<String, dynamic> _$MetricsToJson(_Metrics instance) => <String, dynamic>{
  'totalStations': instance.totalStations,
  'highRiskStationsCount': instance.highRiskStationsCount,
  'peakWaterLevel': instance.peakWaterLevel,
  'peakWaterStation': instance.peakWaterStation,
  'maxRain1h': instance.maxRain1h,
  'maxRain24h': instance.maxRain24h,
};
