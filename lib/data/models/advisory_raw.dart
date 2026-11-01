import 'package:freezed_annotation/freezed_annotation.dart';

part 'advisory_raw.freezed.dart';
part 'advisory_raw.g.dart';

@freezed
abstract class AdvisoryRaw with _$AdvisoryRaw {
  const factory AdvisoryRaw({
    required String id,
    required String source,
    required String authorName,
    required String authorHandle,
    required String publishedAt,
    required String cleanedText,
    required String severity,
    required String passability,
    required String depthCategory,
    required int depthInches,
    required String road,
    required String landmark,
    required String city,
    required Map<String, double> coordinates,
    required List<Map<String, dynamic>> locationPins,
  }) = _AdvisoryRaw;

  factory AdvisoryRaw.fromJson(Map<String, dynamic> json) => _$AdvisoryRawFromJson(json);
}
