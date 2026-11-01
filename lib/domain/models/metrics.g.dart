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
  peakWaterStationId: json['peakWaterStationId'] as String,
  maxRain1h: (json['maxRain1h'] as num).toDouble(),
  maxRain1hStation: json['maxRain1hStation'] as String,
  maxRain1hStationId: json['maxRain1hStationId'] as String,
  maxRain24h: (json['maxRain24h'] as num).toDouble(),
  maxRain24hStation: json['maxRain24hStation'] as String,
  maxRain24hStationId: json['maxRain24hStationId'] as String,
);

Map<String, dynamic> _$MetricsToJson(_Metrics instance) => <String, dynamic>{
  'totalStations': instance.totalStations,
  'highRiskStationsCount': instance.highRiskStationsCount,
  'peakWaterLevel': instance.peakWaterLevel,
  'peakWaterStation': instance.peakWaterStation,
  'peakWaterStationId': instance.peakWaterStationId,
  'maxRain1h': instance.maxRain1h,
  'maxRain1hStation': instance.maxRain1hStation,
  'maxRain1hStationId': instance.maxRain1hStationId,
  'maxRain24h': instance.maxRain24h,
  'maxRain24hStation': instance.maxRain24hStation,
  'maxRain24hStationId': instance.maxRain24hStationId,
};
