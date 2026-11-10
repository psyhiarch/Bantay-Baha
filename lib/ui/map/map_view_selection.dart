part of 'map_view.dart';

extension _MapViewSelectionActions on _MapViewState {
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
    final requestKey = '$id:${widget.focusRequestId ?? ''}';
    if (id == null ||
        requestKey == _handledRequestedStationKey ||
        _controller == null ||
        !_layersReady) {
      return;
    }
    final station = _stationById(stations, id);
    // Data may still be loading; a later build will retry.
    if (station == null || !_hasValidCoordinates(station)) return;

    // Marked synchronously so repeated builds can't queue duplicates, and so
    // closing the card later doesn't bring it back.
    _handledRequestedStationKey = requestKey;
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
    _updateState(() => _selectedStationId = stationId);
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
    _updateState(() => _selectedStationId = null);
  }

  Future<void> _setRoadVisibility(bool visible) async {
    _updateState(() => _showHazardRoads = visible);
    final controller = _controller;
    if (controller == null || !_layersReady) return;
    try {
      await controller.setLayerVisibility(_MapViewState._roadLayerId, visible);
    } catch (error) {
      debugPrint('Unable to change road layer visibility: $error');
    }
  }
}
