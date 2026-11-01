// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryRaw _$TelemetryRawFromJson(Map<String, dynamic> json) =>
    _TelemetryRaw(
      success: json['success'] as bool?,
      scrapedAt: json['scrapedAt'] as String?,
      cachedAt: json['cachedAt'] as String?,
      metrics: json['metrics'] as Map<String, dynamic>?,
      stations: (json['stations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$TelemetryRawToJson(_TelemetryRaw instance) =>
    <String, dynamic>{
      'success': instance.success,
      'scrapedAt': instance.scrapedAt,
      'cachedAt': instance.cachedAt,
      'metrics': instance.metrics,
      'stations': instance.stations,
    };
