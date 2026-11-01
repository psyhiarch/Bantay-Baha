


import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
abstract class Weather with _$Weather {


  const factory Weather({
  required double metroManilaRainMmHr,
  required double metroManilaRain24hMm,
  required double forecast3hTotalMm,
  required String trend,
  required String conditionLabel,
  }) = _Weather;

}
