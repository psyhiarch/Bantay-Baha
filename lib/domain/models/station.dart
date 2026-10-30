class Station {
  final String stationId;
  final String stationName;
  final double latitude;
  final double longitude;
  final double rain10min;
  final double rain1h;
  final double rain3h;
  final double rain24h;
  final double waterLevel;
  final String riskLevel;
  final double temperatureC;
  final double heatIndexC;
  final double humidityPercent;

  const Station({
    required this.stationId,
    required this.stationName,
    required this.latitude,
    required this.longitude,
    required this.rain10min,
    required this.rain1h,
    required this.rain3h,
    required this.rain24h,
    required this.waterLevel,
    required this.riskLevel,
    required this.temperatureC,
    required this.heatIndexC,
    required this.humidityPercent,
  });
}
