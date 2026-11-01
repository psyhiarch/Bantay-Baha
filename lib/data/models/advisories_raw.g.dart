// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisories_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdvisoriesRaw _$AdvisoriesRawFromJson(Map<String, dynamic> json) =>
    _AdvisoriesRaw(
      success: json['success'] as bool?,
      scrapedAt: json['scrapedAt'] as String?,
      advisories: (json['advisories'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      activeFloodCount: (json['activeFloodCount'] as num?)?.toInt(),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AdvisoriesRawToJson(_AdvisoriesRaw instance) =>
    <String, dynamic>{
      'success': instance.success,
      'scrapedAt': instance.scrapedAt,
      'advisories': instance.advisories,
      'totalCount': instance.totalCount,
      'activeFloodCount': instance.activeFloodCount,
      'meta': instance.meta,
    };
