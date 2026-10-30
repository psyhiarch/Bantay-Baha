

import 'package:freezed_annotation/freezed_annotation.dart';

part 'road.freezed.dart';

@freezed
abstract class Road with _$Road{

  const factory Road({
    required String id,
    required String name,
    required String riskLevel,
    required double depthCm,
    required bool isFlooded,
    required String severity,
    required String passability,
  }) = _Road;
}
