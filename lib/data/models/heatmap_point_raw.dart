

import 'package:freezed_annotation/freezed_annotation.dart';

part 'heatmap_point_raw.freezed.dart';
part 'heatmap_point_raw.g.dart';

@freezed
abstract class HeatmapPointRaw with _$HeatmapPointRaw {

  const factory HeatmapPointRaw({
    required double lat,
    required double lng,
    required double intensity,
    required double depthCm,
    required String category,
    required double radius,
    required bool isFlooded,
  }) = _HeatmapPointRaw;

  factory HeatmapPointRaw.fromJson(Map<String, dynamic> json) => _$HeatmapPointRawFromJson(json);
}
