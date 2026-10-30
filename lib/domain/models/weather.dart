class Weather {
  final double metroManilaRainMmHr;
  final double metroManilaRain24hMm;
  final double forecast3hTotalMm;
  final String trend;
  final String conditionLabel;

  const Weather({
    required this.metroManilaRainMmHr,
    required this.metroManilaRain24hMm,
    required this.forecast3hTotalMm,
    required this.trend,
    required this.conditionLabel,
  });
}
