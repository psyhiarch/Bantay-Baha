part of 'map_view.dart';

extension _MapViewRouteActions on _MapViewState {
  void _beginRoutePlanning() {
    _routeRequestId++;
    _updateState(() {
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
    _updateState(() {
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
    _updateState(() => _routePickerOpen = true);
    await showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.transparent,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final mediaQuery = MediaQuery.of(context);
          final availableHeight =
              mediaQuery.size.height - mediaQuery.viewInsets.bottom - 48;
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 520,
                maxHeight: min(mediaQuery.size.height * .82, availableHeight),
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
          );
        },
      ),
    );
    if (mounted) {
      _updateState(() {
        _routePickerOpen = false;
        if (_routeStart == null) _routeStartLabel = null;
        if (_routeDestination == null) _routeDestinationLabel = null;
      });
    }
  }

  void _cancelRoutePlanning() {
    _routeRequestId++;
    _updateState(() {
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
    _updateState(() {
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
    _updateState(() {
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
    _updateState(() {
      _routeStart = null;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();
  }

  void _clearDestinationWhileSearching(String _) {
    if (_routeDestination == null) return;
    _updateState(() {
      _routeDestination = null;
      _plannedRoute = null;
      _routeError = null;
    });
    _syncRoutePickerMarkers();
  }

  Future<void> _useMyLocation() async {
    _updateState(() {
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
      _updateState(() {
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
      if (mounted) _updateState(() => _locationError = error.message);
    } catch (error) {
      if (mounted) {
        _updateState(
          () => _locationError =
              'Could not get your location. Try again or search for a place.',
        );
      }
      debugPrint('Unable to get current location: $error');
    } finally {
      if (mounted) _updateState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _clearRouteOverlay() async {
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setGeoJsonSource(
        _MapViewState._plannedRouteSourceId,
        _routeLineFeatureCollection(),
      );
      await controller.setGeoJsonSource(
        _MapViewState._routeMarkersSourceId,
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
      _updateState(() {
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
    _updateState(() {
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
      _updateState(
        () => _routeError = 'Choose both a start and a destination first.',
      );
      return;
    }
    final model = context.read<HomeViewModel>();
    final requestId = ++_routeRequestId;
    _updateState(() {
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
      _updateState(() {
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
      _updateState(() {
        _routePickStep = 0;
        _routeError = error.message;
      });
    } catch (error) {
      if (!mounted || requestId != _routeRequestId) return;
      _updateState(() {
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
        _MapViewState._plannedRouteSourceId,
        _routeLineFeatureCollection(route.coordinates),
      );
      await controller.setGeoJsonSource(
        _MapViewState._routeMarkersSourceId,
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
        _MapViewState._routeMarkersSourceId,
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
}
