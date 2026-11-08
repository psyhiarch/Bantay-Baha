import 'dart:convert';

import 'package:http/http.dart' as http;

class RouteCandidate {
  const RouteCandidate({
    required this.coordinates,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  final List<List<double>> coordinates;
  final double distanceMeters;
  final double durationSeconds;
}

class RoutePlace {
  const RoutePlace({
    required this.id,
    required this.label,
    required this.detail,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String label;
  final String detail;
  final double latitude;
  final double longitude;
}

class RoutePlanningException implements Exception {
  const RoutePlanningException(this.message);

  final String message;

  @override
  String toString() => message;
}

class RoutePlanningService {
  const RoutePlanningService({this._client});

  final http.Client? _client;
  static const _timeout = Duration(seconds: 20);

  Future<List<RouteCandidate>> findRoutes({
    required double startLatitude,
    required double startLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    final uri = Uri.https('bahaba.ph', '/api/route', {
      'from': '$startLatitude,$startLongitude',
      'to': '$destinationLatitude,$destinationLongitude',
    });

    http.Response response;
    try {
      response = await (_client == null ? http.get(uri) : _client.get(uri))
          .timeout(_timeout);
    } on Exception catch (error) {
      throw RoutePlanningException('Route service unavailable: $error');
    }

    if (response.statusCode == 422) {
      throw const RoutePlanningException(
        'Choose start and destination points within the Philippines.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const RoutePlanningException(
        'Route service is unavailable right now. Try again shortly.',
      );
    }

    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['available'] == false) {
        throw const RoutePlanningException(
          'Route service is unavailable right now. Try again shortly.',
        );
      }
      final rawRoutes = body['routes'] as List<dynamic>? ?? const [];
      return rawRoutes.map((raw) {
        final route = Map<String, dynamic>.from(raw as Map);
        final rawCoordinates =
            route['coordinates'] as List<dynamic>? ?? const [];
        final coordinates = rawCoordinates.map((point) {
          final pair = point as List<dynamic>;
          if (pair.length < 2 || pair[0] is! num || pair[1] is! num) {
            throw const FormatException('Route geometry is invalid.');
          }
          return [(pair[0] as num).toDouble(), (pair[1] as num).toDouble()];
        }).toList();
        final distance = route['distanceM'];
        final duration = route['durationSec'];
        if (coordinates.length < 2 || distance is! num || duration is! num) {
          throw const FormatException('Route details are incomplete.');
        }
        return RouteCandidate(
          coordinates: coordinates,
          distanceMeters: distance.toDouble(),
          durationSeconds: duration.toDouble(),
        );
      }).toList();
    } on RoutePlanningException {
      rethrow;
    } catch (error) {
      throw RoutePlanningException('Could not read route results: $error');
    }
  }

  Future<List<RoutePlace>> searchPlaces(String query) async {
    if (query.trim().length < 2) return const [];
    final uri = Uri.https('bahaba.ph', '/api/geocode/search', {
      'q': query.trim(),
      'feat': 'route',
    });
    try {
      final response =
          await (_client == null ? http.get(uri) : _client.get(uri)).timeout(
            _timeout,
          );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return const [];
      }
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final results = body['results'] as List<dynamic>? ?? const [];
      return results.map((raw) {
        final place = Map<String, dynamic>.from(raw as Map);
        final latitude = place['latitude'];
        final longitude = place['longitude'];
        if (place['label'] is! String ||
            latitude is! num ||
            longitude is! num) {
          throw const FormatException('Place result is incomplete.');
        }
        return RoutePlace(
          id:
              place['id']?.toString() ??
              '${place['label']}:$latitude:$longitude',
          label: place['label'] as String,
          detail: place['detail']?.toString() ?? '',
          latitude: latitude.toDouble(),
          longitude: longitude.toDouble(),
        );
      }).toList();
    } catch (_) {
      return const [];
    }
  }
}
