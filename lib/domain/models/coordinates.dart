
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates.freezed.dart';

@freezed
abstract class Coordinates with _$Coordinates {
  factory Coordinates({
    required double lat,
    required double lng
  }) = _Coordinates;
	
}
