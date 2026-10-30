class Road {
  final String id;
  final String name;
  final String riskLevel;
  final double depthCm;
  final bool isFlooded;
  final String severity;
  final String passability;

  const Road({
    required this.id,
    required this.name,
    required this.riskLevel,
    required this.depthCm,
    required this.isFlooded,
    required this.severity,
    required this.passability,
  });
}
