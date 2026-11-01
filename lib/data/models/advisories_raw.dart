import 'package:freezed_annotation/freezed_annotation.dart';

part 'advisories_raw.freezed.dart';
part 'advisories_raw.g.dart';

@freezed
abstract class AdvisoriesRaw with _$AdvisoriesRaw {
  const factory AdvisoriesRaw({
    required bool? success,
    required String? scrapedAt,
    required List<Map<String, dynamic>>? advisories,
    required int? totalCount,
    required int? activeFloodCount,
    required Map<String, dynamic>? meta,
  }) = _AdvisoriesRaw;

  factory AdvisoriesRaw.fromJson(Map<String, dynamic> json) => _$AdvisoriesRawFromJson(json);
}
