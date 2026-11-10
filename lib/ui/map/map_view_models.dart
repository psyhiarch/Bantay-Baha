part of 'map_view.dart';

class _SafeRoute {
  const _SafeRoute({
    required this.coordinates,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.riskPenaltyMinutes,
    required this.instructions,
    required this.via,
  });

  final List<LatLng> coordinates;
  final double distanceMeters;
  final double durationSeconds;
  final double riskPenaltyMinutes;
  final List<RouteInstruction> instructions;
  final List<String> via;
}

class _RankedRoute {
  const _RankedRoute(this.route, this.score);

  final _SafeRoute route;
  final double score;
}

_SafeRoute? _chooseSaferRoute(
  List<RouteCandidate> candidates,
  List<_RoadReport> reports,
  Iterable<Station> stations,
) {
  final ranked = <_RankedRoute>[];
  for (final candidate in candidates) {
    if (candidate.coordinates.length < 2) continue;
    final coordinates = candidate.coordinates
        .map((point) => LatLng(point[1], point[0]))
        .toList();
    var blocked = false;
    var penaltyMinutes = 0.0;
    for (final report in reports) {
      final distance = _distanceToRoute(
        LatLng(report.latitude, report.longitude),
        coordinates,
      );
      if (distance > 150) continue;
      final passability = report.passability.toLowerCase();
      if (passability.contains('closed') ||
          passability.contains('impassable') ||
          passability.contains('not passable')) {
        blocked = true;
        break;
      }
      final severity = report.severity.toLowerCase();
      penaltyMinutes +=
          severity.contains('critical') ||
              severity.contains('severe') ||
              severity.contains('high')
          ? 15
          : severity.contains('moderate') || severity.contains('warning')
          ? 6
          : 2;
    }
    if (blocked) continue;

    for (final station in stations) {
      final severity = station.riskLevel.toLowerCase();
      if (severity.contains('normal') ||
          !_validCoordinates(station.latitude, station.longitude)) {
        continue;
      }
      final distance = _distanceToRoute(
        LatLng(station.latitude, station.longitude),
        coordinates,
      );
      if (distance > 400) continue;
      penaltyMinutes +=
          severity.contains('critical') ||
              severity.contains('alarm') ||
              severity.contains('high')
          ? 12
          : 5;
    }

    final route = _SafeRoute(
      coordinates: coordinates,
      distanceMeters: candidate.distanceMeters,
      durationSeconds: candidate.durationSeconds,
      riskPenaltyMinutes: penaltyMinutes,
      instructions: candidate.instructions,
      via: candidate.via,
    );
    ranked.add(
      _RankedRoute(route, candidate.durationSeconds / 60 + penaltyMinutes),
    );
  }
  if (ranked.isEmpty) return null;
  ranked.sort((a, b) => a.score.compareTo(b.score));
  return ranked.first.route;
}

double _distanceToRoute(LatLng point, List<LatLng> route) {
  if (route.isEmpty) return double.infinity;
  const metersPerDegreeLatitude = 111320.0;
  final longitudeScale =
      metersPerDegreeLatitude * cos(point.latitude * pi / 180);
  final px = point.longitude * longitudeScale;
  final py = point.latitude * metersPerDegreeLatitude;
  var minimum = double.infinity;
  for (var i = 0; i < route.length; i++) {
    final a = route[i];
    final ax = a.longitude * longitudeScale;
    final ay = a.latitude * metersPerDegreeLatitude;
    if (i == route.length - 1) {
      minimum = min(
        minimum,
        sqrt(pow(px - ax, 2) + pow(py - ay, 2)),
      ).toDouble();
      continue;
    }
    final b = route[i + 1];
    final bx = b.longitude * longitudeScale;
    final by = b.latitude * metersPerDegreeLatitude;
    final dx = bx - ax;
    final dy = by - ay;
    final lengthSquared = dx * dx + dy * dy;
    final fraction = lengthSquared == 0
        ? 0.0
        : (((px - ax) * dx + (py - ay) * dy) / lengthSquared)
              .clamp(0.0, 1.0)
              .toDouble();
    final closestX = ax + fraction * dx;
    final closestY = ay + fraction * dy;
    minimum = min(
      minimum,
      sqrt(pow(px - closestX, 2) + pow(py - closestY, 2)),
    ).toDouble();
  }
  return minimum;
}

class _RoadReport {
  const _RoadReport({
    required this.id,
    required this.road,
    required this.landmark,
    required this.city,
    required this.passability,
    required this.depth,
    required this.severity,
    required this.description,
    required this.publishedAt,
    required this.latitude,
    required this.longitude,
    required this.markerColor,
  });

  final String id;
  final String road;
  final String landmark;
  final String city;
  final String passability;
  final String depth;
  final String severity;
  final String description;
  final DateTime publishedAt;
  final double latitude;
  final double longitude;
  final String markerColor;
}

List<_RoadReport> _roadReports(Iterable<Advisory> advisories) {
  final reports = <_RoadReport>[];
  for (final advisory in advisories) {
    final pins = advisory.locationPins
        .where(
          (pin) => _validCoordinates(pin.coordinates.lat, pin.coordinates.lng),
        )
        .toList();
    if (pins.isNotEmpty) {
      for (final pin in pins) {
        reports.add(_reportFromPin(advisory, pin));
      }
    } else if (_validCoordinates(
      advisory.coordinates.lat,
      advisory.coordinates.lng,
    )) {
      reports.add(
        _RoadReport(
          id: 'advisory:${advisory.id}',
          road: advisory.road,
          landmark: advisory.landmark,
          city: advisory.city,
          passability: advisory.passability,
          depth: advisory.depthInches > 0
              ? '${advisory.depthCategory} · ${advisory.depthInches} in'
              : advisory.depthCategory,
          severity: advisory.severity,
          description: advisory.cleanedText,
          publishedAt: advisory.publishedAt,
          latitude: advisory.coordinates.lat,
          longitude: advisory.coordinates.lng,
          markerColor: _reportMarkerColor(
            advisory.severity,
            advisory.passability,
          ),
        ),
      );
    }
  }
  return reports;
}

_RoadReport _reportFromPin(Advisory advisory, LocationPin pin) => _RoadReport(
  id: 'advisory:${advisory.id}:pin:${pin.id}',
  road: pin.road.isEmpty ? advisory.road : pin.road,
  landmark: pin.landmark.isEmpty ? advisory.landmark : pin.landmark,
  city: advisory.city,
  passability: pin.passability,
  depth: pin.depthCategory,
  severity: pin.severity.toString(),
  description: advisory.cleanedText,
  publishedAt: advisory.publishedAt,
  latitude: pin.coordinates.lat,
  longitude: pin.coordinates.lng,
  markerColor: _reportMarkerColor(pin.severity.toString(), pin.passability),
);

bool _validCoordinates(double latitude, double longitude) =>
    latitude.isFinite &&
    longitude.isFinite &&
    latitude >= -90 &&
    latitude <= 90 &&
    longitude >= -180 &&
    longitude <= 180;

List<Road> _validRoads(Iterable<Road> roads) => roads.where((road) {
  if (road.coordinates.length < 2) return false;
  return road.coordinates.every(
    (point) => point.length >= 2 && _validCoordinates(point[1], point[0]),
  );
}).toList();

String _roadLineColor(Road road) {
  final severity = road.severity.toLowerCase();
  if (road.isFlooded ||
      severity.contains('critical') ||
      severity.contains('severe') ||
      severity.contains('high')) {
    return '#D92D20';
  }
  if (severity.contains('moderate') ||
      severity.contains('warning') ||
      severity.contains('medium')) {
    return '#F79009';
  }
  return '#12B76A';
}

String _reportMarkerColor(String severity, String passability) {
  final normalizedPassability = passability.toLowerCase();
  if (normalizedPassability.contains('closed') ||
      normalizedPassability.contains('impassable') ||
      normalizedPassability.contains('not passable')) {
    return '#D92D20';
  }
  final normalizedSeverity = severity.toLowerCase();
  if (normalizedSeverity.contains('high') ||
      normalizedSeverity.contains('severe') ||
      normalizedSeverity.contains('critical')) {
    return '#D92D20';
  }
  if (normalizedSeverity.contains('moderate') ||
      normalizedSeverity.contains('warning') ||
      normalizedSeverity.contains('medium')) {
    return '#F79009';
  }
  return '#12B76A';
}

String _dateLabel(DateTime date) {
  final local = date.toLocal();
  return '${local.month}/${local.day}/${local.year} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
}

Color _riskColor(String level) {
  final risk = level.toUpperCase();
  if (risk.contains('CRITICAL') ||
      risk.contains('ALARM') ||
      risk.contains('SEVERE') ||
      risk.contains('HIGH')) {
    return AppTheme.danger;
  }
  if (risk.contains('WARNING') ||
      risk.contains('ALERT') ||
      risk.contains('WATCH')) {
    return AppTheme.warningAmber;
  }
  if (risk.contains('NORMAL')) return AppTheme.success;
  return AppTheme.brandBlue;
}
