class Metrics {
  final int totalStations;
  final int highRiskStationsCount;
  final double peakWaterLevel;
  final String peakWaterStation;
  final double maxRain1h;
  final double maxRain24h;

  const Metrics({
    required this.totalStations,
    required this.highRiskStationsCount,
    required this.peakWaterLevel,
    required this.peakWaterStation,
    required this.maxRain1h,
    required this.maxRain24h,
  });
}
