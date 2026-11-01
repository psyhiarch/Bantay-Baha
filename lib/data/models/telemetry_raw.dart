

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_raw.freezed.dart';

part 'telemetry_raw.g.dart';

@freezed
abstract class TelemetryRaw with _$TelemetryRaw {
  const factory TelemetryRaw({
    required bool? success,
    required String? scrapedAt,
    required String? cachedAt,
    required Map<String, dynamic>? metrics,
    required List<Map<String, dynamic>>? stations,
  }) = _TelemetryRaw;


  factory TelemetryRaw.fromJson(Map<String, dynamic> json) => _$TelemetryRawFromJson(json);
}