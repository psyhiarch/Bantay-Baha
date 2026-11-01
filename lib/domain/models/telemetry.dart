


import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry.freezed.dart';

@freezed
abstract class Telemetry with _$Telemetry {
  const factory Telemetry({
    required bool success,
    required DateTime scrapedAt,
    required DateTime cachedAt,
    required Metrics metrics,
    required List<Station> stations,
  }) = _Telemetry;
}