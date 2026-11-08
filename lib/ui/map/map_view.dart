import 'dart:async';
import 'dart:math';

import 'package:bantay_baha/data/services/station_history_service.dart';
import 'package:bantay_baha/data/services/route_planning_service.dart';
import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/location_pin.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/map/map_route_args.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

class MapHeaderDelegate extends SliverPersistentHeaderDelegate {
  const MapHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ClipRect(child: SizedBox.expand(child: child));
  }

  @override
  bool shouldRebuild(MapHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key, this.selectedStationId});

  final String? selectedStationId;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with WidgetsBindingObserver {
  static const String _stationSourceId = 'flood-stations-source';
  static const String _pulseLayerId = 'flood-stations-pulse';
  static const String _selectedPulseLayerId = 'flood-stations-selected-pulse';
  static const String _selectedLayerId = 'flood-stations-selected';
  static const String _markerLayerId = 'flood-stations-markers';
  static const String _reportSourceId = 'road-reports-source';
  static const String _reportLayerId = 'road-reports-markers';
  static const String _roadSourceId = 'flood-roads-source';
  static const String _roadLayerId = 'flood-roads-lines';
  static const String _plannedRouteSourceId = 'planned-route-source';
  static const String _plannedRouteLayerId = 'planned-route-line';
  static const String _routeMarkersSourceId = 'route-markers-source';
  static const String _userLocationLayerId = 'user-location-marker';
  static const String _userLocationCoreLayerId = 'user-location-core';
  static const String _routeStartLayerId = 'route-start-marker';
  static const String _routeDestinationLayerId = 'route-destination-marker';

  MapLibreMapController? _controller;

  /// Only the id is stored. The Station itself is looked up from the
  /// ViewModel on every build, so the card never shows stale readings.
  String? _selectedStationId;

  /// The requested station id (from the route) that we've already focused.
  /// This is what stops the card from re-opening after the user closes it.
  String? _handledRequestedStationId;

  String? _stationSignature;
  String? _reportSignature;
  String? _roadSignature;
  bool _styleReady = false;
  bool _layersReady = false;
  bool _showStationOverview = true;
  bool _annotationSyncPending = false;
  bool _annotationSyncRunning = false;
  bool _reportSyncPending = false;
  bool _reportSyncRunning = false;
  bool _roadSyncPending = false;
  bool _roadSyncRunning = false;
  bool _showHazardRoads = true;
  int _routePickStep = 0;
  LatLng? _routeStart;
  LatLng? _routeDestination;
  LatLng? _currentUserLocation;
  String? _routeStartLabel;
  String? _routeDestinationLabel;
  _SafeRoute? _plannedRoute;
  String? _routeError;
  String? _locationError;
  bool _routePickerOpen = false;
  bool _returnToRoutePlannerAfterMapPick = false;
  bool _isFetchingLocation = false;
  int _routeRequestId = 0;
  final RoutePlanningService _routePlanningService =
      const RoutePlanningService();
  bool _hasFramedStations = false;
  bool _pulseUpdatePending = false;
  double _pulseProgress = 0;
  bool _pulseExpanding = true;
  Timer? _pulseTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A different station was requested (e.g. the user went back to the
    // overview and tapped another card). Allow it to be focused again.
    if (oldWidget.selectedStationId != widget.selectedStationId) {
      _handledRequestedStationId = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Don't burn battery pulsing markers while the app isn't visible.
    if (state == AppLifecycleState.resumed) {
      if (!mounted || !_layersReady) return;
      final hasStations = context.read<HomeViewModel>().stations.any(
        _hasValidCoordinates,
      );
      if (hasStations) _startPulseAnimation();
    } else {
      _pulseTimer?.cancel();
      _pulseTimer = null;
    }
  }

  void _onStationFeatureTapped(
    Point<double> point,
    LatLng coordinates,
    String featureId,
    String layerId,
    Annotation? annotation,
  ) {
    if (_routePickStep > 0) return;
    if (layerId == _plannedRouteLayerId) return;
    if (layerId == _roadLayerId) {
      for (final road
          in context.read<HomeViewModel>().flood?.roads ?? const <Road>[]) {
        if ('route:${road.roadId}' == featureId) {
          _showRoadDetails(road);
          return;
        }
      }
      return;
    }
    if (layerId == _reportLayerId) {
      for (final report in _roadReports(
        context.read<HomeViewModel>().advisories,
      )) {
        if (report.id == featureId) {
          _showRoadReportDetails(report);
          return;
        }
      }
      return;
    }
    // Tapping a marker shows the station card. The card's "Details" button
    // opens the full sheet, so we don't stack two popups.
    _selectStation(featureId);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    final stations = model.stations;
    final hasOverviewData =
        stations.isNotEmpty ||
        model.advisories.isNotEmpty ||
        (model.flood?.roads.isNotEmpty ?? false);
    final showMapLegend = _showStationOverview && hasOverviewData;
    final selectedStation = _stationById(stations, _selectedStationId);
    // The station card is independent of the overview (legend) toggle.
    final showSelectedStation =
        !_routePickerOpen && _routePickStep == 0 && selectedStation != null;
    _scheduleAnnotationSync(stations);
    _scheduleReportSync(model.advisories);
    _scheduleRoadSync(model.flood?.roads ?? const <Road>[]);
    _selectRequestedStation(stations);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Station map'),
          leading: IconButton(
            tooltip: 'Back to overview',
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.go('/'),
          ),
          actions: [
            IconButton(
              tooltip: _showStationOverview
                  ? 'Hide map legend'
                  : 'Show map legend',
              onPressed: () =>
                  setState(() => _showStationOverview = !_showStationOverview),
              icon: Icon(
                _showStationOverview
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            IconButton(
              tooltip: 'Plan a safer route',
              onPressed: _toggleRoutePicker,
              icon: const Icon(Icons.alt_route_rounded),
            ),
            IconButton(
              tooltip: 'Refresh stations',
              onPressed: model.isLoading ? null : model.refresh,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        SliverPersistentHeader(
          delegate: MapHeaderDelegate(
            minHeight: 150,
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
            child: Stack(
              children: [
                MapLibreMap(
                  styleString: MapLibreStyles.openfreemapLiberty,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(13.7565, 121.0583),
                    zoom: 7.4,
                  ),
                  compassEnabled: true,
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  onStyleLoadedCallback: () {
                    _styleReady = true;
                    _initializeStationLayers();
                  },
                  featureTapsTriggersMapClick: true,
                  onMapClick: (_, coordinates) =>
                      _handleRouteMapClick(coordinates),
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  doubleClickZoomEnabled: true,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                ),
                if (model.isLoading && stations.isEmpty)
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                if (model.hasFloodError &&
                    stations.isEmpty &&
                    model.advisories.isEmpty &&
                    (model.flood?.roads.isEmpty ?? true))
                  _MapMessage(
                    icon: Icons.cloud_off_outlined,
                    title: 'Station data unavailable',
                    message:
                        model.floodError ?? 'Check your connection and retry.',
                    action: 'Try again',
                    onAction: model.refresh,
                  ),
                if (!model.isLoading &&
                    !model.hasFloodError &&
                    stations.isEmpty &&
                    model.advisories.isEmpty &&
                    (model.flood?.roads.isEmpty ?? true))
                  const _MapMessage(
                    icon: Icons.location_off_outlined,
                    title: 'No stations available',
                    message: 'There are no monitoring stations to display right now.',
                  ),
                if (!_routePickerOpen &&
                    (_routePickStep > 0 ||
                        _plannedRoute != null ||
                        _routeError != null))
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: Row(
                            children: [
                              if (_routePickStep == 3) ...[
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 9),
                              ] else ...[
                                Icon(
                                  _routeError != null
                                      ? Icons.error_outline_rounded
                                      : _plannedRoute != null
                                      ? Icons.alt_route_rounded
                                      : Icons.touch_app_outlined,
                                  color: _routeError != null
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                                const SizedBox(width: 9),
                              ],
                              Expanded(
                                child: Text(
                                  _routePickStep == 1
                                      ? 'Tap map to choose a start'
                                      : _routePickStep == 2
                                      ? 'Tap map to choose a destination'
                                      : _routePickStep == 3
                                      ? 'Finding a route…'
                                      : _routeError ??
                                            'Route ready · ${_distanceLabel(_plannedRoute!.distanceMeters)}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(
                                        color: _routeError != null
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                            : null,
                                      ),
                                ),
                              ),
                              IconButton(
                                tooltip: _routePickStep > 0
                                    ? 'Cancel route planning'
                                    : _routeError != null
                                    ? 'Open route planner'
                                    : 'Open route details',
                                visualDensity: VisualDensity.compact,
                                onPressed: _routePickStep > 0
                                    ? _cancelRoutePlanning
                                    : _toggleRoutePicker,
                                icon: Icon(
                                  _routePickStep > 0
                                      ? Icons.close_rounded
                                      : Icons.open_in_new_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (showMapLegend || showSelectedStation)
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 18,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (showSelectedStation)
                          _SelectedStationCard(
                            station: selectedStation,
                            onClose: _clearSelection,
                            onDetails: () =>
                                _showStationDetails(selectedStation),
                          ),
                        if (showSelectedStation && showMapLegend)
                          const SizedBox(height: 8),
                        if (showMapLegend)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _MapLegend(
                              count: stations.length,
                              reportCount: _roadReports(model.advisories)
                                  .length,
                              roadCount: _validRoads(
                                model.flood?.roads ?? const <Road>[],
                              ).length,
                              showRoads: _showHazardRoads,
                              onRoadVisibilityChanged: _setRoadVisibility,
                              isOffline:
                                  model.isUsingCachedFloodData ||
                                  model.isUsingCachedAdvisories ||
                                  model.hasFloodError,
                              savedAt:
                                  model.floodCacheSavedAt ??
                                  model.advisoriesCacheSavedAt,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Station? _stationById(Iterable<Station> stations, String? id) {
    if (id == null) return null;
    for (final station in stations) {
      if (station.stationId == id) return station;
    }
    return null;
  }

  /// Focuses the station requested through the route, exactly once.
  void _selectRequestedStation(List<Station> stations) {
    final id = widget.selectedStationId;
    if (id == null ||
        id == _handledRequestedStationId ||
        _controller == null ||
        !_layersReady) {
      return;
    }
    final station = _stationById(stations, id);
    // Data may still be loading; a later build will retry.
    if (station == null || !_hasValidCoordinates(station)) return;

    // Marked synchronously so repeated builds can't queue duplicates, and so
    // closing the card later doesn't bring it back.
    _handledRequestedStationId = id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _selectStation(id);
    });
  }

  void _selectStation(String stationId, {bool showDetails = false}) {
    final station = _stationById(
      context.read<HomeViewModel>().stations,
      stationId,
    );
    if (station == null || !_hasValidCoordinates(station) || !mounted) return;
    setState(() => _selectedStationId = stationId);
    if (widget.selectedStationId == stationId) _hasFramedStations = true;
    _controller?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(station.latitude, station.longitude),
        12,
      ),
      duration: const Duration(milliseconds: 500),
    );
    if (showDetails) _showStationDetails(station);
  }

  void _clearSelection() {
    if (_selectedStationId == null) return;
    setState(() => _selectedStationId = null);
  }

  Future<void> _setRoadVisibility(bool visible) async {
    setState(() => _showHazardRoads = visible);
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setLayerVisibility(_roadLayerId, visible);
    } catch (error) {
      debugPrint('Unable to change road layer visibility: $error');
    }
  }

  void _beginRoutePlanning() {
    _routeRequestId++;
    setState(() {
      _routePickerOpen = false;
      _returnToRoutePlannerAfterMapPick = false;
      _routePickStep = 1;
      _routeStart = null;
      _routeDestination = null;
      _routeStartLabel = null;
      _routeDestinationLabel = null;
      _plannedRoute = null;
      _routeError = null;
      _locationError = null;
    });
    _clearRouteOverlay();
  }

  void _beginRoutePointSelection({required bool selectingStart}) {
    _routeRequestId++;
    setState(() {
      _routePickerOpen = false;
      _returnToRoutePlannerAfterMapPick = true;
      _routePickStep = selectingStart ? 1 : 2;
      if (selectingStart) {
        _routeStart = null;
        _routeStartLabel = null;
      } else {
        _routeDestination = null;
        _routeDestinationLabel = null;
      }
      _plannedRoute = null;
      _routeError = null;
      _locationError = null;
    });
    _clearRouteOverlay();
  }

  Future<void> _toggleRoutePicker() async {
    if (_routePickerOpen) {
      Navigator.of(context, rootNavigator: true).maybePop();
      return;
    }
    setState(() => _routePickerOpen = true);
    await showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 520,
              maxHeight: MediaQuery.sizeOf(context).height * .82,
            ),
            child: SingleChildScrollView(
              child: _RoutePlannerControls(
                step: _routePickStep,
                start: _routeStart,
                destination: _routeDestination,
                startLabel: _routeStartLabel,
                destinationLabel: _routeDestinationLabel,
                route: _plannedRoute,
                error: _routeError,
                locationError: _locationError,
                isFetchingLocation: _isFetchingLocation,
                routePlanningService: _routePlanningService,
                onStartSelected: (place) {
                  _selectRouteStart(place);
                  setDialogState(() {});
                },
                onDestinationSelected: (place) {
                  _selectRouteDestination(place);
                  setDialogState(() {});
                },
                onStartTextChanged: (text) {
                  _clearStartWhileSearching(text);
                  setDialogState(() {});
                },
                onDestinationTextChanged: (text) {
                  _clearDestinationWhileSearching(text);
                  setDialogState(() {});
                },
                onUseMyLocation: () async {
                  final request = _useMyLocation();
                  setDialogState(() {});
                  await request;
                  if (dialogContext.mounted) setDialogState(() {});
                },
                onPickOnMap: () {
                  Navigator.of(dialogContext).pop();
                  _beginRoutePlanning();
                },
                onPickStartOnMap: () {
                  Navigator.of(dialogContext).pop();
                  _beginRoutePointSelection(selectingStart: true);
                },
                onPickDestinationOnMap: () {
                  Navigator.of(dialogContext).pop();
                  _beginRoutePointSelection(selectingStart: false);
                },
                onPlanRoute: () async {
                  final request = _planSelectedRoute();
                  setDialogState(() {});
                  await request;
                  if (dialogContext.mounted) setDialogState(() {});
                },
                onToggle: () => Navigator.of(dialogContext).pop(),
                onCancel: () {
                  _cancelRoutePlanning();
                  setDialogState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
    if (mounted) {
      setState(() {
        _routePickerOpen = false;
        if (_routeStart == null) _routeStartLabel = null;
        if (_routeDestination == null) _routeDestinationLabel = null;
      });
    }
  }

  void _cancelRoutePlanning() {
    _routeRequestId++;
    setState(() {
      _routePickStep = 0;
      _returnToRoutePlannerAfterMapPick = false;
      _routeStart = null;
      _routeDestination = null;
      _routeStartLabel = null;
      _routeDestinationLabel = null;
      _plannedRoute = null;
      _routeError = null;
      _locationError = null;
    });
    _clearRouteOverlay();
  }

  void _selectRouteStart(RoutePlace place) {
    final coordinates = LatLng(place.latitude, place.longitude);
    setState(() {
      _routeStart = coordinates;
      _routeStartLabel = place.label;
      _routePickStep = 0;
      _plannedRoute = null;
      _routeError = null;
      _locationError = null;
    });
    _syncRoutePickerMarkers();
  }

  void _selectRouteDestination(RoutePlace place) {
    final coordinates = LatLng(place.latitude, place.longitude);
    setState(() {
      _routeDestination = coordinates;
      _routeDestinationLabel = place.label;
      _routePickStep = 0;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();
  }

  void _clearStartWhileSearching(String _) {
    if (_routeStart == null) return;
    setState(() {
      _routeStart = null;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();
  }

  void _clearDestinationWhileSearching(String _) {
    if (_routeDestination == null) return;
    setState(() {
      _routeDestination = null;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();
  }

  Future<void> _useMyLocation() async {
    setState(() {
      _isFetchingLocation = true;
      _locationError = null;
      _routePickerOpen = true;
    });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const RoutePlanningException(
          'Turn on Location Services to use your current location.',
        );
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        throw const RoutePlanningException(
          'Location permission was denied. You can search for a starting point instead.',
        );
      }
      if (permission == LocationPermission.deniedForever) {
        throw const RoutePlanningException(
          'Location permission is blocked. Allow it in device settings or search for a starting point.',
        );
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      if (!mounted) return;
      final location = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentUserLocation = location;
        _routeStart = location;
        _routeStartLabel = 'My location';
        _routePickStep = 0;
        _plannedRoute = null;
        _routeError = null;
        _locationError = null;
      });
      _syncRoutePickerMarkers();
      await _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(location, 14),
        duration: const Duration(milliseconds: 450),
      );
    } on RoutePlanningException catch (error) {
      if (mounted) setState(() => _locationError = error.message);
    } catch (error) {
      if (mounted) {
        setState(
          () => _locationError =
              'Could not get your location. Try again or search for a place.',
        );
      }
      debugPrint('Unable to get current location: $error');
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _clearRouteOverlay() async {
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setGeoJsonSource(
        _plannedRouteSourceId,
        _routeLineFeatureCollection(),
      );
      await controller.setGeoJsonSource(
        _routeMarkersSourceId,
        _routeMarkersFeatureCollection(
          start: _routeStart,
          destination: _routeDestination,
          currentLocation: _currentUserLocation,
        ),
      );
    } catch (error) {
      debugPrint('Unable to clear planned route: $error');
    }
  }

  Future<void> _handleRouteMapClick(LatLng coordinates) async {
    if (_routePickStep == 0) return;
    if (_routePickStep == 3) return;
    if (_routePickStep == 1) {
      final returnToPlanner = _returnToRoutePlannerAfterMapPick;
      final destinationIsSet = _routeDestination != null;
      setState(() {
        _routeStart = coordinates;
        _routeStartLabel = 'Map selection';
        _routePickStep = returnToPlanner || destinationIsSet ? 0 : 2;
        _returnToRoutePlannerAfterMapPick = false;
        _routeError = null;
      });
      await _syncRoutePickerMarkers();
      if (returnToPlanner) {
        await _toggleRoutePicker();
      } else if (destinationIsSet) {
        await _planSelectedRoute();
      }
      return;
    }
    final returnToPlanner = _returnToRoutePlannerAfterMapPick;
    final startIsSet = _routeStart != null;
    setState(() {
      _routeDestination = coordinates;
      _routeDestinationLabel = 'Map selection';
      _routePickStep = returnToPlanner || startIsSet ? 0 : 1;
      _returnToRoutePlannerAfterMapPick = false;
    });
    await _syncRoutePickerMarkers();
    if (returnToPlanner) {
      await _toggleRoutePicker();
    } else if (startIsSet) {
      await _planSelectedRoute();
    }
  }

  Future<void> _planSelectedRoute() async {
    final start = _routeStart;
    final destination = _routeDestination;
    if (start == null || destination == null) {
      setState(
        () => _routeError = 'Choose both a start and a destination first.',
      );
      return;
    }
    final model = context.read<HomeViewModel>();
    final requestId = ++_routeRequestId;
    setState(() {
      _routePickStep = 3;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();

    try {
      final candidates = await _routePlanningService.findRoutes(
        startLatitude: start.latitude,
        startLongitude: start.longitude,
        destinationLatitude: destination.latitude,
        destinationLongitude: destination.longitude,
      );
      if (!mounted || requestId != _routeRequestId) return;
      final route = _chooseSaferRoute(
        candidates,
        _roadReports(model.advisories),
        model.stations,
      );
      setState(() {
        _routePickStep = 0;
        _plannedRoute = route;
        _routeError = route == null
            ? candidates.isEmpty
                  ? 'No route was returned for those points. Try different locations.'
                  : 'Every available route crosses a road marked impassable.'
            : null;
      });
      if (route != null) await _showPlannedRoute(route);
    } on RoutePlanningException catch (error) {
      if (!mounted || requestId != _routeRequestId) return;
      setState(() {
        _routePickStep = 0;
        _routeError = error.message;
      });
    } catch (error) {
      if (!mounted || requestId != _routeRequestId) return;
      setState(() {
        _routePickStep = 0;
        _routeError = 'Could not plan this route. Try again.';
      });
      debugPrint('Route planning failed: $error');
    }
  }

  Future<void> _showPlannedRoute(_SafeRoute route) async {
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setGeoJsonSource(
        _plannedRouteSourceId,
        _routeLineFeatureCollection(route.coordinates),
      );
      await controller.setGeoJsonSource(
        _routeMarkersSourceId,
        _routeMarkersFeatureCollection(
          start: _routeStart,
          destination: _routeDestination,
          currentLocation: _currentUserLocation,
        ),
      );
      await _frameMap(controller, route.coordinates);
    } catch (error) {
      debugPrint('Unable to draw planned route: $error');
    }
  }

  Future<void> _syncRoutePickerMarkers() async {
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setGeoJsonSource(
        _routeMarkersSourceId,
        _routeMarkersFeatureCollection(
          start: _routeStart,
          destination: _routeDestination,
          currentLocation: _currentUserLocation,
        ),
      );
    } catch (error) {
      debugPrint('Unable to update route picker markers: $error');
    }
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
        _stationSourceId,
        _stationFeatureCollection(validStations),
      );
      if (validStations.isEmpty) {
        _pulseTimer?.cancel();
        _pulseTimer = null;
      } else {
        _startPulseAnimation();
      }

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
        _reportSourceId,
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
        _roadSourceId,
        _roadFeatureCollection(_validRoads(roads)),
      );
      await controller.setLayerVisibility(_roadLayerId, _showHazardRoads);
      if (clearPlannedRoute && _plannedRoute != null) {
        await controller.setGeoJsonSource(
          _plannedRouteSourceId,
          _routeLineFeatureCollection(),
        );
        await controller.setGeoJsonSource(
          _routeMarkersSourceId,
          _routeMarkersFeatureCollection(currentLocation: _currentUserLocation),
        );
        if (mounted) {
          setState(() {
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
        _stationSourceId,
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
        _reportSourceId,
        _reportFeatureCollection(_roadReports(advisories)),
        promoteId: 'reportId',
      );
      if (!mounted) return;
      final roads =
          context.read<HomeViewModel>().flood?.roads ?? const <Road>[];
      await controller.addGeoJsonSource(
        _roadSourceId,
        _roadFeatureCollection(_validRoads(roads)),
        promoteId: 'roadFeatureId',
      );
      await controller.addGeoJsonSource(
        _plannedRouteSourceId,
        _routeLineFeatureCollection(),
      );
      await controller.addGeoJsonSource(
        _routeMarkersSourceId,
        _routeMarkersFeatureCollection(currentLocation: _currentUserLocation),
      );
      await controller.addLineLayer(
        _roadSourceId,
        _roadLayerId,
        const LineLayerProperties(
          lineColor: [Expressions.get, 'lineColor'],
          lineWidth: 4,
          lineOpacity: .85,
          lineCap: 'round',
          lineJoin: 'round',
        ),
      );
      await controller.setLayerVisibility(_roadLayerId, _showHazardRoads);
      await controller.addCircleLayer(
        _stationSourceId,
        _pulseLayerId,
        const CircleLayerProperties(
          circleRadius: 14,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: .3,
          circleStrokeWidth: 0,
        ),
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _stationSourceId,
        _selectedPulseLayerId,
        const CircleLayerProperties(
          circleRadius: 18,
          circleColor: '#155EEF',
          circleOpacity: .25,
          circleStrokeWidth: 0,
        ),
        filter: [
          '==',
          ['get', 'isSelected'],
          true,
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _stationSourceId,
        _selectedLayerId,
        const CircleLayerProperties(
          circleRadius: 13,
          circleColor: '#FFFFFF',
          circleOpacity: 0,
          circleStrokeWidth: 3.5,
          circleStrokeColor: '#155EEF',
        ),
        filter: [
          '==',
          ['get', 'isSelected'],
          true,
        ],
        enableInteraction: false,
      );
      await controller.addCircleLayer(
        _stationSourceId,
        _markerLayerId,
        const CircleLayerProperties(
          circleRadius: 8,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: 1,
          circleStrokeWidth: 2.5,
          circleStrokeColor: '#FFFFFF',
        ),
      );
      await controller.addLineLayer(
        _plannedRouteSourceId,
        _plannedRouteLayerId,
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
        _reportSourceId,
        _reportLayerId,
        const CircleLayerProperties(
          circleRadius: 7,
          circleColor: [Expressions.get, 'markerColor'],
          circleOpacity: .95,
          circleStrokeWidth: 2,
          circleStrokeColor: '#FFFFFF',
        ),
      );
      await controller.addCircleLayer(
        _routeMarkersSourceId,
        _userLocationLayerId,
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
        _routeMarkersSourceId,
        _userLocationCoreLayerId,
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
        _routeMarkersSourceId,
        _routeStartLayerId,
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
        _routeMarkersSourceId,
        _routeDestinationLayerId,
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

  void _startPulseAnimation() {
    if (_pulseTimer != null) return;
    // Slower tick with a bigger step: looks the same, roughly half the
    // platform-channel traffic of the previous 80 ms timer.
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 150), (_) async {
      final controller = _controller;
      if (!mounted ||
          controller == null ||
          !_layersReady ||
          _pulseUpdatePending) {
        return;
      }
      _pulseUpdatePending = true;
      _pulseProgress += _pulseExpanding ? .12 : -.12;
      if (_pulseProgress >= 1) {
        _pulseProgress = 1;
        _pulseExpanding = false;
      } else if (_pulseProgress <= 0) {
        _pulseProgress = 0;
        _pulseExpanding = true;
      }
      try {
        await controller.setLayerProperties(
          _pulseLayerId,
          CircleLayerProperties(
            circleRadius: 14 + 10 * _pulseProgress,
            circleOpacity: .3 * (1 - _pulseProgress),
          ),
        );
        // Nothing selected means nothing to animate on the selected ring.
        if (_selectedStationId != null) {
          await controller.setLayerProperties(
            _selectedPulseLayerId,
            CircleLayerProperties(
              circleRadius: 18 + 10 * _pulseProgress,
              circleOpacity: .28 * (1 - _pulseProgress),
            ),
          );
        }
      } catch (error) {
        _pulseTimer?.cancel();
        _pulseTimer = null;
        debugPrint('Unable to animate station marker pulse: $error');
      } finally {
        _pulseUpdatePending = false;
      }
    });
  }

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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pulseTimer?.cancel();
    _controller?.onFeatureTapped.remove(_onStationFeatureTapped);
    super.dispose();
  }

  Future<void> _showStationDetails(Station station) async {
    final history = context.read<HomeViewModel>().historyFor(station.stationId);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _RiskDot(color: _riskColor(station.riskLevel), size: 12),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        station.stationName,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    _RiskChip(level: station.riskLevel),
                  ],
                ),
                const SizedBox(height: 20),
                _MetricRow(
                  label: 'Water level',
                  value: '${station.waterLevel.toStringAsFixed(1)} m',
                ),
                _MetricRow(
                  label: 'Water level change · 1h',
                  value: '${station.waterLevelDelta1h.toStringAsFixed(1)} m',
                ),
                _MetricRow(
                  label: 'Rainfall · 10 min',
                  value: '${station.rain10m.toStringAsFixed(1)} mm',
                ),
                _MetricRow(
                  label: 'Rainfall · 1 hour',
                  value: '${station.rain1h.toStringAsFixed(1)} mm',
                ),
                _MetricRow(
                  label: 'Rainfall · 24 hours',
                  value: '${station.rain24h.toStringAsFixed(1)} mm',
                ),
                _MetricRow(label: 'Water risk', value: station.waterRiskLevel),
                _MetricRow(label: 'Rain risk', value: station.rainRiskLevel),
                _MetricRow(
                  label: 'Updated',
                  value: _dateLabel(station.lastUpdated),
                ),
                const SizedBox(height: 20),
                _StationHistorySection(readings: history),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StationHistorySection extends StatelessWidget {
  const _StationHistorySection({required this.readings});

  final List<StationReading> readings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    if (readings.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'History is collecting. Readings appear here as the app refreshes.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last 24 hours',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _HistoryChart(
          title: 'Water level',
          unit: 'm',
          color: AppTheme.brandBlue,
          values: readings.map((reading) => reading.waterLevel).toList(),
          times: readings.map((reading) => reading.recordedAt).toList(),
        ),
        const SizedBox(height: 10),
        _HistoryChart(
          title: 'Rainfall · 1 hour',
          unit: 'mm',
          color: AppTheme.warningAmber,
          values: readings.map((reading) => reading.rain1h).toList(),
          times: readings.map((reading) => reading.recordedAt).toList(),
        ),
      ],
    );
  }
}

class _HistoryChart extends StatelessWidget {
  const _HistoryChart({
    required this.title,
    required this.unit,
    required this.color,
    required this.values,
    required this.times,
  });

  final String title;
  final String unit;
  final Color color;
  final List<double> values;
  final List<DateTime> times;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final latest = values.last;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                '${latest.toStringAsFixed(1)} $unit',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            'Range ${values.reduce((a, b) => a < b ? a : b).toStringAsFixed(1)}–${values.reduce((a, b) => a > b ? a : b).toStringAsFixed(1)} $unit',
            style: theme.textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 112,
            width: double.infinity,
            child: CustomPaint(
              painter: _HistoryChartPainter(
                values: values,
                times: times,
                color: color,
                gridColor: scheme.outlineVariant,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_timeLabel(times.first), style: theme.textTheme.labelSmall),
              Text(_timeLabel(times.last), style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  String _timeLabel(DateTime time) {
    final local = time.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}

class _HistoryChartPainter extends CustomPainter {
  const _HistoryChartPainter({
    required this.values,
    required this.times,
    required this.color,
    required this.gridColor,
  });

  final List<double> values;
  final List<DateTime> times;
  final Color color;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    const inset = 5.0;
    final chart = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: .55)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = chart.top + chart.height * i / 3;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), gridPaint);
    }

    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final spread = maxValue - minValue;
    final padding = spread == 0
        ? (maxValue.abs() * .1).clamp(.1, 1.0).toDouble()
        : spread * .15;
    final low = minValue - padding;
    final high = maxValue + padding;
    final timeStart = times.first.millisecondsSinceEpoch.toDouble();
    final timeSpan =
        (times.last.millisecondsSinceEpoch - times.first.millisecondsSinceEpoch)
            .toDouble();

    Offset pointAt(int index) {
      final x = timeSpan == 0
          ? chart.left +
                (values.length == 1
                    ? chart.width / 2
                    : chart.width * index / (values.length - 1))
          : chart.left +
                (times[index].millisecondsSinceEpoch - timeStart) /
                    timeSpan *
                    chart.width;
      final y =
          chart.bottom - (values[index] - low) / (high - low) * chart.height;
      return Offset(x, y);
    }

    final line = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (var i = 1; i < values.length; i++) {
      line.lineTo(pointAt(i).dx, pointAt(i).dy);
    }
    final fill = Path.from(line)
      ..lineTo(chart.right, chart.bottom)
      ..lineTo(chart.left, chart.bottom)
      ..close();
    canvas.drawPath(fill, Paint()..color = color.withValues(alpha: .12));
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawCircle(pointAt(values.length - 1), 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_HistoryChartPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.times != times ||
      oldDelegate.color != color ||
      oldDelegate.gridColor != gridColor;
}

class _SafeRoute {
  const _SafeRoute({
    required this.coordinates,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.riskPenaltyMinutes,
  });

  final List<LatLng> coordinates;
  final double distanceMeters;
  final double durationSeconds;
  final double riskPenaltyMinutes;
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

class _MapLegend extends StatelessWidget {
  const _MapLegend({
    required this.count,
    required this.reportCount,
    required this.roadCount,
    required this.showRoads,
    required this.onRoadVisibilityChanged,
    required this.isOffline,
    required this.savedAt,
  });
  final int count;
  final int reportCount;
  final int roadCount;
  final bool showRoads;
  final ValueChanged<bool> onRoadVisibilityChanged;
  final bool isOffline;
  final DateTime? savedAt;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width - 28,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$count stations · $roadCount routes · $reportCount reports',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge,
                ),
                if (roadCount > 0)
                  Row(
                    children: [
                      const Icon(Icons.alt_route_rounded, size: 18),
                      const SizedBox(width: 8),
                      const Expanded(child: Text('Flood hazard routes')),
                      Switch.adaptive(
                        value: showRoads,
                        onChanged: onRoadVisibilityChanged,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _legendItem('High', AppTheme.danger),
                    const SizedBox(width: 10),
                    _legendItem('Watch', AppTheme.warningAmber),
                    const SizedBox(width: 10),
                    _legendItem('Normal', AppTheme.success),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Road report pins use the same severity colors.',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (isOffline) ...[
                  const SizedBox(height: 5),
                  Text(
                    'Offline data · saved ${_savedAgeLabel(savedAt)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.warningAmber,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _legendItem(String label, Color color) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _RiskDot(color: color, size: 8),
      const SizedBox(width: 4),
      Text(label),
    ],
  );
}

class _RoutePlannerControls extends StatelessWidget {
  const _RoutePlannerControls({
    required this.step,
    required this.start,
    required this.destination,
    required this.startLabel,
    required this.destinationLabel,
    required this.route,
    required this.error,
    required this.locationError,
    required this.isFetchingLocation,
    required this.routePlanningService,
    required this.onStartSelected,
    required this.onDestinationSelected,
    required this.onStartTextChanged,
    required this.onDestinationTextChanged,
    required this.onUseMyLocation,
    required this.onPickOnMap,
    required this.onPickStartOnMap,
    required this.onPickDestinationOnMap,
    required this.onPlanRoute,
    required this.onToggle,
    required this.onCancel,
  });

  final int step;
  final LatLng? start;
  final LatLng? destination;
  final String? startLabel;
  final String? destinationLabel;
  final _SafeRoute? route;
  final String? error;
  final String? locationError;
  final bool isFetchingLocation;
  final RoutePlanningService routePlanningService;
  final ValueChanged<RoutePlace> onStartSelected;
  final ValueChanged<RoutePlace> onDestinationSelected;
  final ValueChanged<String> onStartTextChanged;
  final ValueChanged<String> onDestinationTextChanged;
  final VoidCallback onUseMyLocation;
  final VoidCallback onPickOnMap;
  final VoidCallback onPickStartOnMap;
  final VoidCallback onPickDestinationOnMap;
  final VoidCallback onPlanRoute;
  final VoidCallback onToggle;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.alt_route_rounded,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan a safer route',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Routes are checked against flood reports',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (route != null)
                  IconButton(
                    tooltip: 'Clear planned route',
                    onPressed: onCancel,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                IconButton(
                  tooltip: 'Close route planner',
                  onPressed: onToggle,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _placeField(
              context,
              label: 'Start',
              icon: Icons.trip_origin_rounded,
              selectedLabel: startLabel,
              onSelected: onStartSelected,
              onTextChanged: onStartTextChanged,
              onPickOnMap: onPickStartOnMap,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: isFetchingLocation ? null : onUseMyLocation,
                icon: isFetchingLocation
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_rounded, size: 17),
                label: const Text('Use my location'),
              ),
            ),
            const SizedBox(height: 8),
            _placeField(
              context,
              label: 'Destination',
              icon: Icons.location_on_outlined,
              selectedLabel: destinationLabel,
              onSelected: onDestinationSelected,
              onTextChanged: onDestinationTextChanged,
              onPickOnMap: onPickDestinationOnMap,
            ),
            if (locationError != null) ...[
              const SizedBox(height: 6),
              Text(
                locationError!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            if (error != null) ...[
              const SizedBox(height: 6),
              Text(
                error!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            if (step == 1 || step == 2) ...[
              const SizedBox(height: 8),
              Text(
                step == 1
                    ? 'Tap the map to set your starting point.'
                    : 'Tap the map to set your destination.',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (step == 3) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(minHeight: 2),
              const SizedBox(height: 7),
              Text(
                'Finding a route and checking flood reports…',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (route != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(
                    alpha: .55,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_distanceLabel(route!.distanceMeters)}  ·  ${_durationLabel(route!.durationSeconds + route!.riskPenaltyMinutes * 60)}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      route!.riskPenaltyMinutes > 0
                          ? 'Hazard reports are near this route. Check conditions before leaving.'
                          : 'No matching hazards found along this route.',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: step == 3 ? null : onPickOnMap,
                    icon: const Icon(Icons.touch_app_outlined),
                    label: const Text('Pick on map'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: step == 3 || start == null || destination == null
                        ? null
                        : onPlanRoute,
                    icon: const Icon(Icons.alt_route_rounded),
                    label: Text(route == null ? 'Find route' : 'Recalculate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeField(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String? selectedLabel,
    required ValueChanged<RoutePlace> onSelected,
    required ValueChanged<String> onTextChanged,
    required VoidCallback onPickOnMap,
  }) => Autocomplete<RoutePlace>(
    key: ValueKey('$label:${selectedLabel ?? ''}'),
    initialValue: TextEditingValue(text: selectedLabel ?? ''),
    displayStringForOption: (place) => place.label,
    optionsBuilder: (value) => routePlanningService.searchPlaces(value.text),
    onSelected: onSelected,
    optionsViewBuilder: (context, select, options) => Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 210),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              for (final place in options)
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.place_outlined),
                  title: Text(
                    place.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: place.detail.isEmpty
                      ? null
                      : Text(
                          place.detail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  onTap: () => select(place),
                ),
            ],
          ),
        ),
      ),
    ),
    fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onTextChanged,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Search an address or landmark',
            prefixIcon: Icon(icon),
            suffixIcon: IconButton(
              tooltip: 'Choose $label on map',
              onPressed: onPickOnMap,
              icon: const Icon(Icons.map_outlined),
            ),
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
  );
}

String _distanceLabel(double meters) => meters >= 1000
    ? '${(meters / 1000).toStringAsFixed(1)} km'
    : '${meters.round()} m';

String _durationLabel(double seconds) =>
    '~${max(1, (seconds / 60).round())} min';

String _savedAgeLabel(DateTime? savedAt) {
  if (savedAt == null) return 'time unavailable';
  final age = DateTime.now().difference(savedAt);
  if (age.inMinutes < 1) return 'just now';
  if (age.inMinutes < 60) return '${age.inMinutes} min ago';
  if (age.inHours < 24) return '${age.inHours} h ago';
  return '${age.inDays} d ago';
}

class _SelectedStationCard extends StatelessWidget {
  const _SelectedStationCard({
    required this.station,
    required this.onClose,
    required this.onDetails,
  });
  final Station station;
  final VoidCallback onClose;
  final VoidCallback onDetails;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RiskDot(color: _riskColor(station.riskLevel), size: 10),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  station.stationName,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              _RiskChip(level: station.riskLevel),
              IconButton(
                onPressed: onClose,
                tooltip: 'Close station preview',
                icon: const Icon(Icons.close_rounded),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Water  ${station.waterLevel.toStringAsFixed(1)} m',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  'Rain  ${station.rain1h.toStringAsFixed(1)} mm/h',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(onPressed: onDetails, child: const Text('Details')),
            ],
          ),
        ],
      ),
    ),
  );
}

class _RiskDot extends StatelessWidget {
  const _RiskDot({required this.color, required this.size});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _RiskChip extends StatelessWidget {
  const _RiskChip({required this.level});
  final String level;
  @override
  Widget build(BuildContext context) {
    final color = _riskColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

class _MapMessage extends StatelessWidget {
  const _MapMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
  });
  final IconData icon;
  final String title;
  final String message;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: IgnorePointer(
      ignoring: action == null,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: .93),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 42,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(message, textAlign: TextAlign.center),
                if (action != null)
                  TextButton(onPressed: onAction, child: Text(action!)),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
