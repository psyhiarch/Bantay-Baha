
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates_raw.freezed.dart';
part 'coordinates_raw.g.dart';

@freezed
abstract class CoordinatesRaw with _$CoordinatesRaw {
  factory CoordinatesRaw({
    required double lat,
    required double lng
  }) = _CoordinatesRaw;
	
  factory CoordinatesRaw.fromJson(Map<String, dynamic> json) => _$CoordinatesRawFromJson(json);
}
