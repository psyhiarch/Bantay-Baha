import 'package:freezed_annotation/freezed_annotation.dart';

part 'advisories_raw.freezed.dart';

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
}
