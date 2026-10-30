class HeatmapPoint {
  final double lat;
  final double lng;
  final double intensity;
  final double depthCm;

  const HeatmapPoint({
    required this.lat,
    required this.lng,
    required this.intensity,
    required this.depthCm,
  });
}
