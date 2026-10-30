
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return MapLibreMap();
  }
}