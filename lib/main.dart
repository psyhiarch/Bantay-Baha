import 'package:bantay_baha/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

void main() {
  MapLibreMap.preWarm();
  runApp(MaterialApp(home: HomeView(),));
}