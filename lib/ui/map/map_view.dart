import 'dart:async';
import 'dart:math';

import 'package:bantay_baha/data/services/map_effects_service.dart';
import 'package:bantay_baha/data/services/station_history_service.dart';
import 'package:bantay_baha/data/services/route_planning_service.dart';
import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/location_pin.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

part 'map_view_selection.dart';
part 'map_view_routes.dart';
part 'map_view_layers.dart';
part 'map_view_station_details.dart';
part 'map_view_models.dart';
part 'map_view_controls.dart';
part 'map_view_route_controls.dart';

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
  const MapView({super.key, this.selectedStationId, this.focusRequestId});

  final String? selectedStationId;
  final String? focusRequestId;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const String _stationSourceId = 'flood-stations-source';
  static const String _stationHaloLayerId = 'flood-stations-halo';
  static const String _selectedStationHaloLayerId =
      'flood-stations-selected-halo';
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
  /// Stops repeated builds from reopening the card for the same navigation.
  String? _handledRequestedStationKey;

  String? _stationSignature;
  String? _reportSignature;
  String? _roadSignature;
  bool _styleReady = false;
  bool _layersReady = false;
  bool _annotationSyncPending = false;
  bool _annotationSyncRunning = false;
  bool _reportSyncPending = false;
  bool _reportSyncRunning = false;
  bool _roadSyncPending = false;
  bool _roadSyncRunning = false;
  bool _showHazardRoads = true;
  MapEffectMode _mapEffectMode = MapEffectMode.staticMode;
  bool _mapEffectPreferenceLoaded = false;
  bool _mapEffectUpdatePending = false;
  double _mapEffectProgress = 0;
  Timer? _mapEffectTimer;
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
  final MapEffectsService _mapEffectsService = MapEffectsService();
  bool _hasFramedStations = false;

  @override
  void initState() {
    super.initState();
    _loadMapEffectPreference();
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
    final showMapLegend = hasOverviewData;
    final selectedStation = _stationById(stations, _selectedStationId);
    final showSelectedStation =
        !_routePickerOpen && _routePickStep == 0 && selectedStation != null;
    final showRouteStatus =
        !_routePickerOpen &&
        (_routePickStep > 0 || _plannedRoute != null || _routeError != null);
    _scheduleAnnotationSync(stations);
    _scheduleReportSync(model.advisories);
    _scheduleRoadSync(model.flood?.roads ?? const <Road>[]);
    _selectRequestedStation(stations);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mapHeight =
              constraints.maxHeight -
              kToolbarHeight -
              MediaQuery.paddingOf(context).top;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Station map'),
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    tooltip: 'Plan route',
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
                  minHeight: mapHeight,
                  maxHeight: mapHeight,
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
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>{
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
                              model.floodError ??
                              'Check your connection and retry.',
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
                      if (showRouteStatus)
                        Positioned(
                          bottom: 76,
                          right: 14,
                          child: Material(
                            color: Theme.of(context).colorScheme.surface
                                .withValues(alpha: .97),
                            elevation: 5,
                            shadowColor: Colors.black.withValues(alpha: .18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 7, 5, 7),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 250,
                                ),
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
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                            : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
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
                                          : _plannedRoute != null
                                          ? () => _showRouteDetails(context)
                                          : _toggleRoutePicker,
                                      icon: Icon(
                                        _routePickStep > 0
                                            ? Icons.close_rounded
                                            : _plannedRoute != null
                                            ? Icons.directions_outlined
                                            : Icons.open_in_new_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (showMapLegend)
                        Positioned(
                          top: 14,
                          left: 14,
                          child: _MapLegend(
                            count: stations.length,
                            reportCount: _roadReports(model.advisories).length,
                            roadCount: _validRoads(
                              model.flood?.roads ?? const <Road>[],
                            ).length,
                            isOffline:
                                model.isUsingCachedFloodData ||
                                model.isUsingCachedAdvisories ||
                                model.hasFloodError,
                            savedAt:
                                model.floodCacheSavedAt ??
                                model.advisoriesCacheSavedAt,
                          ),
                        ),
                      if (showSelectedStation)
                        Positioned(
                          left: 14,
                          right: 14,
                          bottom: showRouteStatus ? 138 : 76,
                          child: _SelectedStationCard(
                            station: selectedStation,
                            onClose: _clearSelection,
                            onDetails: () =>
                                _showStationDetails(selectedStation),
                          ),
                        ),
                      Positioned(
                        right: 16,
                        bottom: 14,
                        child: FloatingActionButton.small(
                          heroTag: 'toggle-flood-hazard-routes',
                          tooltip: _showHazardRoads
                              ? 'Hide flood hazard routes'
                              : 'Show flood hazard routes',
                          onPressed: () =>
                              _setRoadVisibility(!_showHazardRoads),
                          child: Icon(
                            _showHazardRoads
                                ? Icons.route_rounded
                                : Icons.route_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapEffectTimer?.cancel();
    _controller?.onFeatureTapped.remove(_onStationFeatureTapped);
    super.dispose();
  }

  void _updateState(VoidCallback callback) => setState(callback);
}
