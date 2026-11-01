// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdvisoryRaw _$AdvisoryRawFromJson(Map<String, dynamic> json) => _AdvisoryRaw(
  id: json['id'] as String,
  source: json['source'] as String,
  authorName: json['authorName'] as String,
  authorHandle: json['authorHandle'] as String,
  publishedAt: json['publishedAt'] as String,
  cleanedText: json['cleanedText'] as String,
  severity: json['severity'] as String,
  passability: json['passability'] as String,
  depthCategory: json['depthCategory'] as String,
  depthInches: (json['depthInches'] as num).toInt(),
  road: json['road'] as String,
  landmark: json['landmark'] as String,
  city: json['city'] as String,
  coordinates: (json['coordinates'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  locationPins: (json['locationPins'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
);

Map<String, dynamic> _$AdvisoryRawToJson(_AdvisoryRaw instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'authorName': instance.authorName,
      'authorHandle': instance.authorHandle,
      'publishedAt': instance.publishedAt,
      'cleanedText': instance.cleanedText,
      'severity': instance.severity,
      'passability': instance.passability,
      'depthCategory': instance.depthCategory,
      'depthInches': instance.depthInches,
      'road': instance.road,
      'landmark': instance.landmark,
      'city': instance.city,
      'coordinates': instance.coordinates,
      'locationPins': instance.locationPins,
    };
