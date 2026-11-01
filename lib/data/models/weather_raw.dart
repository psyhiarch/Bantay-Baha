




import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_raw.freezed.dart';
part 'weather_raw.g.dart';

@freezed
abstract class WeatherRaw with _$WeatherRaw {


  const factory WeatherRaw({
  required double metroManilaRainMmHr,
  required double metroManilaRain24hMm,
  required double forecast3hTotalMm,
  required String trend,
  required String conditionLabel,
  }) = _WeatherRaw;

  factory WeatherRaw.fromJson(Map<String, dynamic> json) => _$WeatherRawFromJson(json);
}
