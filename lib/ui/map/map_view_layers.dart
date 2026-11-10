part of 'map_view.dart';

extension _MapViewLayerActions on _MapViewState {
  Future<void> _loadMapEffectPreference() async {
    try {
      final mode = await _mapEffectsService.load();
      if (!mounted) return;
      _mapEffectMode = mode;
      _mapEffectPreferenceLoaded = true;
      _configureMapEffects();
    } catch (error) {
      debugPrint('Unable to load map effect preference: $error');
    }
  }

  void _configureMapEffects() {
    if (!_mapEffectPreferenceLoaded || !_layersReady) return;
    if (_mapEffectMode != MapEffectMode.staticMode) {
      _startMapEffectAnimation();
    } else {
      _mapEffectTimer?.cancel();
      _mapEffectTimer = null;
    }
  }

  void _startMapEffectAnimation() {
    if (_mapEffectTimer != null) return;
    _mapEffectTimer = Timer.periodic(const Duration(milliseconds: 120), (
      _,
    ) async {
      final controller = _controller;
      if (!mounted ||
          controller == null ||
          !_layersReady ||
          _mapEffectUpdatePending) {
        return;
      }
      _mapEffectUpdatePending = true;
      _mapEffectProgress = (_mapEffectProgress + .025) % 1;
      final progress = _mapEffectProgress;
      try {
        final phase = .5 - .5 * cos(progress * 2 * pi);
        await controller.setLayerProperties(
          _MapViewState._stationHaloLayerId,
          CircleLayerProperties(
            circleRadius: 14 + 2 * phase,
            circleOpacity: .1 + .06 * phase,
          ),
        );
        await controller.setLayerProperties(
          _MapViewState._selectedStationHaloLayerId,
          CircleLayerProperties(
            circleRadius: 18 + 2.5 * phase,
            circleOpacity: .08 + .06 * phase,
            circleStrokeWidth: 1.5 + .75 * phase,
          ),
        );
      } catch (error) {
        _mapEffectTimer?.cancel();
        _mapEffectTimer = null;
        debugPrint('Unable to animate map effect: $error');
      } finally {
        _mapEffectUpdatePending = false;
      }
    });
  }

  void _scheduleAnnotationSync(List<Station> stations) {
    if (_controller == null ||
        !_layersReady ||
        _annotationSyncPending ||
        _annotationSyncRunning) {
      return;
    }
    final signature =
        '${stations.map((station) => '${station.stationId}:${station.latitude}:${station.longitude}:${station.riskLevel}').join('|')}|selected:${_selectedStationId ?? ''}';
    if (signature == _stationSignature) return;
    _stationSignature = signature;
    _annotationSyncPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _annotationSyncPending = false;
      if (mounted) _syncStationAnnotations(stations);
    });
  }

  Future<void> _syncStationAnnotations(List<Station> stations) async {
    final controller = _controller;
    if (controller == null || !_layersReady || _annotationSyncRunning) return;
    _annotationSyncRunning = true;
    final validStations = stations.where(_hasValidCoordinates).toList();
    final reportPoints = _roadReports(context.read<HomeViewModel>().advisories)
        .map((report) => LatLng(report.latitude, report.longitude))
        .toList();
    try {
      await controller.setGeoJsonSource(
        _MapViewState._stationSourceId,
        _stationFeatureCollection(validStations),
      );

      // If a specific station was requested, don't also frame the whole
      // network: that would fight with (and undo) the focus animation.
      final focusRequested =
          _stationById(validStations, widget.selectedStationId) != null;
      if (!_hasFramedStations &&
          !focusRequested &&
          (validStations.isNotEmpty || reportPoints.isNotEmpty)) {
        await _frameMap(controller, [
          ...validStations.map(
            (station) => LatLng(station.latitude, station.longitude),
          ),
          ...reportPoints,
        ]);
        _hasFramedStations = true;
      }
    } catch (error) {
      debugPrint('Unable to update map station annotations: $error');
    } finally {
      _annotationSyncRunning = false;
      if (mounted) {
        _scheduleAnnotationSync(context.read<HomeViewModel>().stations);
      }
    }
  }

  void _scheduleReportSync(List<Advisory> advisories) {
    if (_controller == null ||
        !_layersReady ||
        _reportSyncPending ||
        _reportSyncRunning) {
      return;
    }
    final reports = _roadReports(advisories);
    final signature = reports
        .map(
          (report) =>
              '${report.id}:${report.latitude}:${report.longitude}:${report.markerColor}',
        )
        .join('|');
    if (signature == _reportSignature) return;
    _reportSignature = signature;
    _reportSyncPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportSyncPending = false;
      if (mounted) _syncRoadReports(advisories);
    });
  }

  Future<void> _syncRoadReports(List<Advisory> advisories) async {
    final controller = _controller;
    if (controller == null || !_layersReady || _reportSyncRunning) return;
    _reportSyncRunning = true;
    try {
      await controller.setGeoJsonSource(
        _MapViewState._reportSourceId,
        _reportFeatureCollection(_roadReports(advisories)),
      );
    } catch (error) {
      debugPrint('Unable to update map road report markers: $error');
    } finally {
      _reportSyncRunning = false;
      if (mounted) {
        _scheduleReportSync(context.read<HomeViewModel>().advisories);
      }
    }
  }

  void _scheduleRoadSync(List<Road> roads) {
    if (_controller == null ||
        !_layersReady ||
        _roadSyncPending ||
        _roadSyncRunning) {
      return;
    }
    final validRoads = _validRoads(roads);
    final signature = validRoads
        .map(
          (road) =>
              '${road.roadId}:${road.isFlooded}:${road.severity}:${road.coordinates.hashCode}',
        )
        .join('|');
    if (signature == _roadSignature) return;
    final roadsChanged = _roadSignature != null;
    _roadSignature = signature;
    _roadSyncPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _roadSyncPending = false;
      if (mounted) _syncRoads(roads, clearPlannedRoute: roadsChanged);
    });
  }

  Future<void> _syncRoads(
    List<Road> roads, {
    bool clearPlannedRoute = false,
  }) async {
    final controller = _controller;
    if (controller == null || !_layersReady || _roadSyncRunning) return;
    _roadSyncRunning = true;
    try {
      await controller.setGeoJsonSource(
        _MapViewState._roadSourceId,
        _roadFeatureCollection(_validRoads(roads)),
      );
      await controller.setLayerVisibility(
        _MapViewState._roadLayerId,
        _showHazardRoads,
      );
      if (clearPlannedRoute && _plannedRoute != null) {
        await controller.setGeoJsonSource(
          _MapViewState._plannedRouteSourceId,
          _routeLineFeatureCollection(),
        );
        await controller.setGeoJsonSource(
          _MapViewState._routeMarkersSourceId,
          _routeMarkersFeatureCollection(currentLocation: _currentUserLocation),
        );
        if (mounted) {
          _updateState(() {
            _plannedRoute = null;
            _routeStart = null;
            _routeDestination = null;
            _routeStartLabel = null;
            _routeDestinationLabel = null;
            _routeError = 'Road data changed. Plan a new route.';
          });
        }
      }
    } catch (error) {
      debugPrint('Unable to update flood road layer: $error');
    } finally {
      _roadSyncRunning = false;
      if (mounted) {
        _scheduleRoadSync(
          context.read<HomeViewModel>().flood?.roads ?? const <Road>[],
        );
      }
    }
  }

  Future<void> _initializeStationLayers() async {
    final controller = _controller;
    if (controller == null || !_styleReady || _layersReady) return;
    try {
      await controller.addGeoJsonSource(
        _MapViewState._stationSourceId,
        _stationFeatureCollection(
          context
              .read<HomeViewModel>()
              .stations
              .where(_hasValidCoordinates)
              .toList(),
        ),
        promoteId: 'stationId',
      );
      if (!mounted) return;
      final advisories = context.read<HomeViewModel>().advisories;
      await controller.addGeoJsonSource(
        _MapViewState._reportSourceId,
        _reportFeatureCollection(_roadReports(advisories)),
        promoteId: 'reportId',
      );
      if (!mounted) return;
      final roads =
          context.read<HomeViewModel>().flood?.roads ?? const <Road>[];
      await controller.addGeoJsonSource(
        _MapViewState._roadSourceId,
        _roadFeatureCollection(_validRoads(roads)),
        promoteId: 'roadFeatureId',
      );
      await controller.addGeoJsonSource(
        _MapViewState._plannedRouteSourceId,
        _routeLineFeatureCollection(),
      );
      await controller.addGeoJsonSource(
        _MapViewState._routeMarkersSourceId,
        _routeMarkersFeatureCollection(currentLocation: _currentUserLocation),
      );
      await controller.addLineLayer(
        _MapViewState._roadSourceId,
        _MapViewState._roadLayerId,
        const LineLayerProperties(
          lineColor: [Expressions.get, 'lineColor'],
          lineWidth: 4,
          lineOpacity: .85,
          lineCap: 'round',
          lineJoin: 'round',
        ),
      );
      await controller.setLayerVisibility(
        _MapViewState._roadLayerId,
        _showHazardRoads,
      );
      await controller.addCircleLayer(
        _MapViewState._stationSourceId,
        _MapViewState._stationHaloLayerId,
        const CircleLayerProperties(
          circleRadius: 14,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: .14,
          circleStrokeWidth: 0,
        ),
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._stationSourceId,
        _MapViewState._selectedStationHaloLayerId,
        const CircleLayerProperties(
          circleRadius: 18,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: .12,
          circleStrokeColor: [Expressions.get, 'markerColor'],
          circleStrokeWidth: 2,
        ),
        filter: [
          '==',
          ['get', 'isSelected'],
          true,
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._stationSourceId,
        _MapViewState._selectedLayerId,
        const CircleLayerProperties(
          circleRadius: 13,
          circleColor: '#FFFFFF',
          circleOpacity: 0,
          circleStrokeWidth: 3,
          circleStrokeColor: [Expressions.get, 'markerColor'],
        ),
        filter: [
          '==',
          ['get', 'isSelected'],
          true,
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._stationSourceId,
        _MapViewState._markerLayerId,
        const CircleLayerProperties(
          circleRadius: 8,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: 1,
          circleStrokeWidth: 2.5,
          circleStrokeColor: '#FFFFFF',
        ),
      );
      await controller.addLineLayer(
        _MapViewState._plannedRouteSourceId,
        _MapViewState._plannedRouteLayerId,
        const LineLayerProperties(
          lineColor: '#155EEF',
          lineWidth: 6,
          lineOpacity: .98,
          lineCap: 'round',
          lineJoin: 'round',
        ),
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._reportSourceId,
        _MapViewState._reportLayerId,
        const CircleLayerProperties(
          circleRadius: 7,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: .95,
          circleStrokeWidth: 2,
          circleStrokeColor: '#FFFFFF',
        ),
      );
      await controller.addCircleLayer(
        _MapViewState._routeMarkersSourceId,
        _MapViewState._userLocationLayerId,
        const CircleLayerProperties(
          circleRadius: 14,
          circleColor: '#2E90FA',
          circleOpacity: .35,
          circleStrokeWidth: 2,
          circleStrokeColor: '#FFFFFF',
        ),
        filter: [
          '==',
          ['get', 'kind'],
          'user-location',
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._routeMarkersSourceId,
        _MapViewState._userLocationCoreLayerId,
        const CircleLayerProperties(
          circleRadius: 6,
          circleColor: '#1570EF',
          circleStrokeWidth: 2,
          circleStrokeColor: '#FFFFFF',
        ),
        filter: [
          '==',
          ['get', 'kind'],
          'user-location',
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._routeMarkersSourceId,
        _MapViewState._routeStartLayerId,
        const CircleLayerProperties(
          circleRadius: 10,
          circleColor: '#12B76A',
          circleStrokeWidth: 3,
          circleStrokeColor: '#FFFFFF',
        ),
        filter: [
          '==',
          ['get', 'kind'],
          'route-start',
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _MapViewState._routeMarkersSourceId,
        _MapViewState._routeDestinationLayerId,
        const CircleLayerProperties(
          circleRadius: 10,
          circleColor: '#D92D20',
          circleStrokeWidth: 3,
          circleStrokeColor: '#FFFFFF',
        ),
        filter: [
          '==',
          ['get', 'kind'],
          'route-destination',
        ],
        enableInteraction: false,
      );
      controller.onFeatureTapped.add(_onStationFeatureTapped);
      _layersReady = true;
      if (!mounted) return;
      _configureMapEffects();
      _scheduleAnnotationSync(context.read<HomeViewModel>().stations);
      _scheduleReportSync(context.read<HomeViewModel>().advisories);
      _scheduleRoadSync(
        context.read<HomeViewModel>().flood?.roads ?? const <Road>[],
      );
      final plannedRoute = _plannedRoute;
      if (plannedRoute != null) {
        _showPlannedRoute(plannedRoute);
      } else {
        _syncRoutePickerMarkers();
      }
      _selectRequestedStation(context.read<HomeViewModel>().stations);
    } catch (error) {
      debugPrint('Unable to initialize station map layers: $error');
    }
  }

  Map<String, dynamic> _reportFeatureCollection(List<_RoadReport> reports) => {
    'type': 'FeatureCollection',
    'features': reports
        .map(
          (report) => {
            'type': 'Feature',
            'id': report.id,
            'properties': {
              'reportId': report.id,
              'markerColor': report.markerColor,
            },
            'geometry': {
              'type': 'Point',
              'coordinates': [report.longitude, report.latitude],
            },
          },
        )
        .toList(),
  };

  Map<String, dynamic> _roadFeatureCollection(List<Road> roads) => {
    'type': 'FeatureCollection',
    'features': roads
        .map(
          (road) => {
            'type': 'Feature',
            'id': 'route:${road.roadId}',
            'properties': {
              'roadFeatureId': 'route:${road.roadId}',
              'lineColor': _roadLineColor(road),
            },
            'geometry': {'type': 'LineString', 'coordinates': road.coordinates},
          },
        )
        .toList(),
  };

  Map<String, dynamic> _routeLineFeatureCollection([List<LatLng>? route]) {
    final features = <Map<String, dynamic>>[];
    if (route != null && route.length >= 2) {
      features.add({
        'type': 'Feature',
        'id': 'planned-safe-route',
        'geometry': {
          'type': 'LineString',
          'coordinates': route
              .map((point) => [point.longitude, point.latitude])
              .toList(),
        },
        'properties': const {'kind': 'planned-safe-route'},
      });
    }
    return {'type': 'FeatureCollection', 'features': features};
  }

  Map<String, dynamic> _routeMarkersFeatureCollection({
    LatLng? start,
    LatLng? destination,
    LatLng? currentLocation,
  }) {
    final features = <Map<String, dynamic>>[];
    if (currentLocation != null) {
      features.add(_routePointFeature('user-location', currentLocation));
    }
    if (start != null) {
      features.add(_routePointFeature('route-start', start));
    }
    if (destination != null) {
      features.add(_routePointFeature('route-destination', destination));
    }
    return {'type': 'FeatureCollection', 'features': features};
  }

  Map<String, dynamic> _routePointFeature(String kind, LatLng point) => {
    'type': 'Feature',
    'id': kind,
    'geometry': {
      'type': 'Point',
      'coordinates': [point.longitude, point.latitude],
    },
    'properties': {'kind': kind},
  };

  Future<void> _showRoadDetails(Road road) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.alt_route_rounded),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      road.roadName,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  _RiskChip(level: road.severity),
                ],
              ),
              const SizedBox(height: 16),
              if (road.description.isNotEmpty) ...[
                Text(
                  road.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
              ],
              _MetricRow(
                label: 'Flood status',
                value: road.isFlooded ? 'Flooded' : 'Not reported flooded',
              ),
              _MetricRow(
                label: 'Estimated depth',
                value:
                    '${road.estimatedDepthCm.toStringAsFixed(0)} cm · ${road.depthCategory}',
              ),
              _MetricRow(
                label: 'Hazard score',
                value: road.hazardScore.toStringAsFixed(1),
              ),
              _MetricRow(
                label: 'Road classification',
                value: road.roadClassification,
              ),
              if (road.nationalRoute.isNotEmpty)
                _MetricRow(label: 'Route', value: road.nationalRoute),
              if (road.drivableVehicles.isNotEmpty)
                _MetricRow(
                  label: 'Reported suitable for',
                  value: road.drivableVehicles.join(', '),
                ),
              if (road.isNearRiver)
                const _MetricRow(
                  label: 'Nearby condition',
                  value: 'Near a river',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRoadReportDetails(_RoadReport report) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_car_filled_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      report.road.isEmpty ? 'Road flood report' : report.road,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  _RiskChip(level: report.severity),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                report.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              _MetricRow(label: 'Passability', value: report.passability),
              _MetricRow(label: 'Water depth', value: report.depth),
              _MetricRow(label: 'Nearby landmark', value: report.landmark),
              _MetricRow(label: 'City', value: report.city),
              _MetricRow(
                label: 'Reported',
                value: _dateLabel(report.publishedAt),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _stationFeatureCollection(List<Station> stations) => {
    'type': 'FeatureCollection',
    'features': stations
        .map(
          (station) => {
            'type': 'Feature',
            'id': station.stationId,
            'properties': {
              'stationId': station.stationId,
              'markerColor': _colorHex(_riskColor(station.riskLevel)),
              'isSelected': station.stationId == _selectedStationId,
            },
            'geometry': {
              'type': 'Point',
              'coordinates': [station.longitude, station.latitude],
            },
          },
        )
        .toList(),
  };

  Future<void> _frameMap(
    MapLibreMapController controller,
    List<LatLng> points,
  ) async {
    if (points.isEmpty) return;
    if (points.length == 1) {
      final point = points.single;
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(point, 10),
        duration: const Duration(milliseconds: 450),
      );
      return;
    }

    final latitudes = points.map((point) => point.latitude);
    final longitudes = points.map((point) => point.longitude);
    final south = latitudes.reduce((a, b) => a < b ? a : b);
    final north = latitudes.reduce((a, b) => a > b ? a : b);
    final west = longitudes.reduce((a, b) => a < b ? a : b);
    final east = longitudes.reduce((a, b) => a > b ? a : b);
    final latPadding = (north - south) * .03 + .001;
    final lngPadding = (east - west) * .03 + .001;
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(south - latPadding, west - lngPadding),
          northeast: LatLng(north + latPadding, east + lngPadding),
        ),
        left: 36,
        top: 80,
        right: 36,
        bottom: 150,
      ),
      duration: const Duration(milliseconds: 450),
    );
  }

  bool _hasValidCoordinates(Station station) =>
      station.latitude.isFinite &&
      station.longitude.isFinite &&
      station.latitude >= -90 &&
      station.latitude <= 90 &&
      station.longitude >= -180 &&
      station.longitude <= 180;

  String _colorHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}
