import 'package:freezed_annotation/freezed_annotation.dart';

part 'flood_raw.freezed.dart';

part 'flood_raw.g.dart';

@freezed
abstract class FloodRaw with _$FloodRaw {
  const factory FloodRaw({
    required bool? success,
    required String? calculatedAt,
    required String? scrapedAt,
    required Map<String, dynamic>? metrics,
    required List<Map<String, dynamic>>? stations,
    required List<Map<String, dynamic>>? roads,
    required List<Map<String, dynamic>>? heatmapPoints,
    required Map<String, dynamic>? weather,
  }) = _FloodRaw;

  factory FloodRaw.fromJson(Map<String, dynamic> json) =>
      _$FloodRawFromJson(json);
  
}
