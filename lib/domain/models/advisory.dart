


import 'package:bantay_baha/domain/models/coordinates.dart';
import 'package:bantay_baha/domain/models/location_pin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'advisory.freezed.dart';

@freezed
abstract class Advisory with _$Advisory {
  const factory Advisory({
    required String id,
    required String source,
    required String authorName,
    required String authorHandle,
    required DateTime publishedAt,
    required String cleanedText,
    required String severity,
    required String passability,
    required String depthCategory,
    required int depthInches,
    required String road,
    required String landmark,
    required String city,
    required Coordinates coordinates,
    required List<LocationPin> locationPins
  }) = _Advisory;
}