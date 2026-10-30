import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const String _apiUrl = 'https://bahaba.nicolei.games/api/flood/live';

  static const String _sourceId = 'flood-stations';
  static const String _pulseLayerId = 'flood-station-pulse';
  static const String _markerLayerId = 'flood-station-markers';

  static const List<dynamic> _riskColorExpression = [
    'match',
    ['get', 'riskLevel'],
    'CRITICAL',
    '#DC2626',
    'ALARM',
    '#F97316',
    'WARNING',
    '#EAB308',
    'NORMAL',
    '#22C55E',
    '#64748B',
  ];

  MapLibreMapController? _mapController;

  final List<Map<String, dynamic>> _stations = [];

  Timer? _refreshTimer;
  Timer? _pulseTimer;

  bool _styleLoaded = false;
  bool _sourceCreated = false;
  bool _pulseLayerCreated = false;
  bool _markerLayerCreated = false;
  bool _installingLayer = false;
  bool _fetching = false;
  bool _pulseUpdating = false;
  bool _isLoading = true;

  double _pulsePhase = 0;

  String? _error;

  @override
  void initState() {
    super.initState();

    _fetchStations();

    // Refresh station readings every five minutes.
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _fetchStations(),
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _pulseTimer?.cancel();
    super.dispose();
  }

  // --------------------------------------------------
  // FETCH LIVE FLOOD STATIONS
  // --------------------------------------------------

  Future<void> _fetchStations() async {
    if (_fetching) return;

    _fetching = true;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw Exception('API returned HTTP ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map || decoded['stations'] is! List) {
        throw const FormatException('Missing stations array in API response.');
      }

      final newStations = <Map<String, dynamic>>[];

      for (final item in decoded['stations'] as List) {
        if (item is! Map) continue;

        final station = Map<String, dynamic>.from(item);

        final latitude = station['latitude'];
        final longitude = station['longitude'];

        if (latitude is! num || longitude is! num) {
          continue;
        }

        if (latitude < -90 ||
            latitude > 90 ||
            longitude < -180 ||
            longitude > 180) {
          continue;
        }

        // Use uppercase risk values for consistent styling.
        station['riskLevel'] = (station['riskLevel'] ?? 'NORMAL')
            .toString()
            .toUpperCase();

        newStations.add(station);
      }

      if (!mounted) return;

      setState(() {
        _stations
          ..clear()
          ..addAll(newStations);

        _isLoading = false;
        _error = null;
      });

      if (_styleLoaded) {
        await _installOrUpdateLayer();
      }
    } catch (e) {
      debugPrint('Station API error: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Unable to load flood stations.';
        });
      }
    } finally {
      _fetching = false;
    }
  }

  // --------------------------------------------------
  // CONVERT STATIONS TO GEOJSON
  // --------------------------------------------------

  Map<String, dynamic> _buildGeoJson() {
    return {
      'type': 'FeatureCollection',
      'features': _stations.map((station) {
        return {
          'type': 'Feature',

          // MapLibre returns this ID when the feature is tapped.
          'id': station['stationId'].toString(),

          'properties': {
            'stationId': station['stationId'] ?? '',
            'stationName': station['stationName'] ?? 'Unknown station',

            'riskLevel': station['riskLevel'] ?? 'NORMAL',

            'rain10m': station['rain10m'] ?? 0,
            'rain1h': station['rain1h'] ?? 0,
            'rain24h': station['rain24h'] ?? 0,

            'waterLevel': station['waterLevel'] ?? 0,
            'waterLevelDelta1h': station['waterLevelDelta1h'] ?? 0,

            'rainRiskLevel': station['rainRiskLevel'] ?? 'UNKNOWN',

            'waterRiskLevel': station['waterRiskLevel'] ?? 'UNKNOWN',

            'lastUpdated': station['lastUpdated'] ?? '',
          },

          'geometry': {
            'type': 'Point',

            // GeoJSON uses [longitude, latitude].
            'coordinates': [
              (station['longitude'] as num).toDouble(),
              (station['latitude'] as num).toDouble(),
            ],
          },
        };
      }).toList(),
    };
  }

  // --------------------------------------------------
  // MAP INITIALIZATION AND FEATURE TAP LISTENER
  // --------------------------------------------------

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;

    // Listen for taps on GeoJSON features.
    controller.onFeatureTapped.add((
      point,
      coordinates,
      id,
      layerId,
      annotation,
    ) {
      // Ignore taps on other map layers.
      if (layerId != _markerLayerId) return;

      Map<String, dynamic>? station;

      for (final item in _stations) {
        if (item['stationId'].toString() == id) {
          station = item;
          break;
        }
      }

      if (station != null && mounted) {
        _showStationDetails(station);
      }
    });

    if (_styleLoaded) {
      _installOrUpdateLayer();
    }
  }

  void _onStyleLoaded() {
    _styleLoaded = true;
    _installOrUpdateLayer();
  }

  // --------------------------------------------------
  // ADD GEOJSON SOURCE AND CIRCLE LAYERS
  // --------------------------------------------------

  Future<void> _installOrUpdateLayer() async {
    final controller = _mapController;

    if (controller == null || !_styleLoaded || _installingLayer) {
      return;
    }

    _installingLayer = true;

    try {
      // Create one source shared by both layers.
      if (!_sourceCreated) {
        await controller.addGeoJsonSource(_sourceId, _buildGeoJson());

        _sourceCreated = true;
      }

      // First layer: expanding, fading pulse.
      if (!_pulseLayerCreated) {
        await controller.addCircleLayer(
          _sourceId,
          _pulseLayerId,
          const CircleLayerProperties(
            circleRadius: 9,
            circleColor: _riskColorExpression,
            circleOpacity: 0.22,
            circleBlur: 0.3,
          ),
          enableInteraction: false,
        );

        _pulseLayerCreated = true;
      }

      // Second layer: visible, clickable station marker.
      if (!_markerLayerCreated) {
        await controller.addCircleLayer(
          _sourceId,
          _markerLayerId,
          const CircleLayerProperties(
            circleRadius: 6,
            circleColor: _riskColorExpression,
            circleOpacity: 1,
            circleStrokeColor: '#FFFFFF',
            circleStrokeWidth: 1.5,
          ),
          enableInteraction: true,
        );

        _markerLayerCreated = true;
      }

      // Update the same source with fresh readings.
      await controller.setGeoJsonSource(_sourceId, _buildGeoJson());

      _startPulseAnimation();
    } catch (e) {
      debugPrint('Map layer error: $e');

      if (mounted) {
        setState(() {
          _error = 'Unable to display station markers.';
        });
      }
    } finally {
      _installingLayer = false;
    }
  }

  // --------------------------------------------------
  // PULSATING ANIMATION
  // --------------------------------------------------

  void _startPulseAnimation() {
    if (_pulseTimer != null) return;

    _pulseTimer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      final controller = _mapController;

      if (!mounted ||
          controller == null ||
          !_styleLoaded ||
          !_pulseLayerCreated ||
          _pulseUpdating) {
        return;
      }

      _pulseUpdating = true;

      try {
        _pulsePhase += 0.18;

        if (_pulsePhase > 2 * math.pi) {
          _pulsePhase -= 2 * math.pi;
        }

        // Smoothly oscillate between 0 and 1.
        final wave = (math.sin(_pulsePhase) + 1) / 2;

        final radius = 8 + (wave * 8);
        final opacity = 0.28 * (1 - wave);

        await controller.setLayerProperties(
          _pulseLayerId,
          CircleLayerProperties(
            circleRadius: radius,
            circleColor: _riskColorExpression,
            circleOpacity: opacity,
            circleBlur: 0.3,
          ),
        );
      } catch (e) {
        debugPrint('Pulse animation error: $e');
        _pulseTimer?.cancel();
        _pulseTimer = null;
      } finally {
        _pulseUpdating = false;
      }
    });
  }

  // --------------------------------------------------
  // STATION DETAILS BOTTOM SHEET
  // --------------------------------------------------

  Color _riskColor(String? value) {
    switch (value?.toUpperCase()) {
      case 'CRITICAL':
        return Colors.red;
      case 'ALARM':
        return Colors.deepOrange;
      case 'WARNING':
        return Colors.amber;
      case 'NORMAL':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  String _formatValue(dynamic value) {
    if (value == null) return '—';

    if (value is num) {
      if (value == value.roundToDouble()) {
        return value.toStringAsFixed(0);
      }

      return value.toStringAsFixed(1);
    }

    return value.toString();
  }

  void _showStationDetails(Map<String, dynamic> station) {
    final risk = (station['riskLevel'] ?? 'UNKNOWN').toString().toUpperCase();

    final updated = DateTime.tryParse(station['lastUpdated']?.toString() ?? '');

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  station['stationName']?.toString() ?? 'Unknown station',
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),

                const SizedBox(height: 8),

                Chip(
                  avatar: Icon(Icons.circle, size: 14, color: _riskColor(risk)),
                  label: Text('Overall risk: $risk'),
                ),

                const Divider(height: 24),

                _readingTile(
                  'Rainfall (10 minutes)',
                  '${_formatValue(station['rain10m'])} mm',
                ),

                _readingTile(
                  'Rainfall (1 hour)',
                  '${_formatValue(station['rain1h'])} mm',
                ),

                _readingTile(
                  'Rainfall (24 hours)',
                  '${_formatValue(station['rain24h'])} mm',
                ),

                _readingTile(
                  'Water level',
                  _formatValue(station['waterLevel']),
                ),

                _readingTile(
                  'Water level change (1 hour)',
                  _formatValue(station['waterLevelDelta1h']),
                ),

                _readingTile(
                  'Rain risk',
                  (station['rainRiskLevel'] ?? 'UNKNOWN').toString(),
                ),

                _readingTile(
                  'Water risk',
                  (station['waterRiskLevel'] ?? 'UNKNOWN').toString(),
                ),

                if (updated != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Last updated: '
                    '${updated.toLocal().toString().split('.').first}',
                    style: Theme.of(sheetContext).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _readingTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          const SizedBox(width: 12),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // MAP UI
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(12.8797, 121.7740),
              zoom: 5,
            ),
            styleString: MapLibreStyles.openfreemapLiberty,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoaded,
          ),

          // Top-left station count and manual refresh.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 4,
                      top: 2,
                      bottom: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flood, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          _isLoading
                              ? 'Loading stations...'
                              : '${_stations.length} flood stations',
                        ),
                        IconButton(
                          tooltip: 'Refresh stations',
                          onPressed: _isLoading ? null : _fetchStations,
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Error message.
          if (_error != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 24,
              child: SafeArea(
                child: Material(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
