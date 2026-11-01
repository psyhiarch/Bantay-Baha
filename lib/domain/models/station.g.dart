// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Station _$StationFromJson(Map<String, dynamic> json) => _Station(
  stationId: json['stationId'] as String,
  stationName: json['stationName'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  geohash: json['geohash'] as String,
  rain10m: (json['rain10m'] as num).toDouble(),
  rain1h: (json['rain1h'] as num).toDouble(),
  rain24h: (json['rain24h'] as num).toDouble(),
  waterLevel: (json['waterLevel'] as num).toDouble(),
  waterLevelDelta1h: (json['waterLevelDelta1h'] as num).toDouble(),
  waterRiskLevel: json['waterRiskLevel'] as String,
  rainRistLevel: json['rainRistLevel'] as String,
  riskLevel: json['riskLevel'] as String,
  lastUpdated: json['lastUpdated'] as String,
);

Map<String, dynamic> _$StationToJson(_Station instance) => <String, dynamic>{
  'stationId': instance.stationId,
  'stationName': instance.stationName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'geohash': instance.geohash,
  'rain10m': instance.rain10m,
  'rain1h': instance.rain1h,
  'rain24h': instance.rain24h,
  'waterLevel': instance.waterLevel,
  'waterLevelDelta1h': instance.waterLevelDelta1h,
  'waterRiskLevel': instance.waterRiskLevel,
  'rainRistLevel': instance.rainRistLevel,
  'riskLevel': instance.riskLevel,
  'lastUpdated': instance.lastUpdated,
};
