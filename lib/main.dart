import 'package:bantay_baha/data/repositories/flood_repository_impl.dart';
import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/dependency_provider.dart';
import 'package:bantay_baha/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

void main() {
  MapLibreMap.preWarm();
  runApp(
    RepositoryProvider(
      floodRepository: FloodRepositoryImpl(floodApiService: FloodApiService()),
      child: MaterialApp(home: HomeView()),
    ),
  );
}
