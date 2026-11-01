

import 'package:bantay_baha/domain/models/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_pin.freezed.dart';

@freezed
abstract class LocationPin with _$LocationPin {

  const factory LocationPin({
    required String id,
    required String road,
    required String landmark,
    required Coordinates coordinates,
    required String depthCategory,
    required String passability,
    required severity,
  }) = _LocationPin;
}