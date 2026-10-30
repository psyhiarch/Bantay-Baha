class FloodRaw {
  final bool success;
  final String calculatedAt;
  final String scrapedAt;
  final Map<String, dynamic> metrics;
  final List<Map<String, dynamic>> stations;
  final List<Map<String, dynamic>> roads;
  final List<Map<String, dynamic>> heatmapPoints;
  final Map<String, dynamic> weather;

  const FloodRaw({
    required this.success,
    required this.calculatedAt,
    required this.scrapedAt,
    required this.metrics,
    required this.stations,
    required this.roads,
    required this.heatmapPoints,
    required this.weather,
  });

  factory FloodRaw.fromJson(Map<String, dynamic> json) {
    return FloodRaw(
      success: json['success'],
      calculatedAt: json['calculatedAt'],
      scrapedAt: json['scrapedAt'],
      metrics: json['metrics'],
      stations: json['stations'],
      roads: json['roads'],
      heatmapPoints: json['heatmapPoints'],
      weather: json['weather'],
    );
  }

}
