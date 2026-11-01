

import 'package:freezed_annotation/freezed_annotation.dart';

part 'heatmap_point.freezed.dart';


@freezed
abstract class HeatmapPoint with _$HeatmapPoint {

  const factory HeatmapPoint({
    required double lat,
    required double lng,
    required double intensity,
    required double depthCm,
    required String category,
    required double radius,
    required bool isFlooded,
  }) = _HeatmapPoint;

}
