

import 'package:bantay_baha/domain/models/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_pin_raw.freezed.dart';
part 'location_pin_raw.g.dart';

@freezed
abstract class LocationPinRaw with _$LocationPinRaw {

  const factory LocationPinRaw({
    required String id,
    required String road,
    required String landmark,
    required Map<String, dynamic> coordinates,
    required String depthCategory,
    required String passability,
    required severity,
  }) = _LocationPinRaw;

  factory LocationPinRaw.fromJson(Map<String, dynamic> json) => _$LocationPinRawFromJson(json);
}