import 'package:bantay_baha/data/models/advisory_raw.dart';
import 'package:bantay_baha/data/models/coordinates_raw.dart';
import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/data/models/heatmap_point_raw.dart';
import 'package:bantay_baha/data/models/location_pin_raw.dart';
import 'package:bantay_baha/data/models/metrics_raw.dart';
import 'package:bantay_baha/data/models/road_raw.dart';
import 'package:bantay_baha/data/models/station_raw.dart';
import 'package:bantay_baha/data/models/telemetry_raw.dart';
import 'package:bantay_baha/data/models/weather_raw.dart';
import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/coordinates.dart';

import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/heatmap_point.dart';
import 'package:bantay_baha/domain/models/location_pin.dart';
import 'package:bantay_baha/domain/models/metrics.dart';
import 'package:bantay_baha/domain/models/road.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';
import 'package:bantay_baha/domain/models/weather.dart';

DateTime _parseDateTime(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    throw FormatException('$fieldName is missing');
  }

  final dateTime = DateTime.tryParse(value);

  if (dateTime == null) {
    throw FormatException('Invalid $fieldName: $value');
  }

  return dateTime;
}

extension FloodRawMapper on FloodRaw {
  Flood toDomain() {
    return Flood(
      success: success ?? false,
      calculatedAt: _parseDateTime(calculatedAt, 'calculatedAt'),
      scrapedAt: _parseDateTime(scrapedAt, 'scrapedAt'),
      metrics: MetricsRaw.fromJson(metrics ?? {}).toDomain(),
      stations:
          stations
              ?.map((item) => StationRaw.fromJson(item).toDomain())
              .toList() ??
          [],
      roads:
          roads?.map((item) => RoadRaw.fromJson(item).toDomain()).toList() ??
          [],
      heatmapPoints:
          heatmapPoints
              ?.map((item) => HeatmapPointRaw.fromJson(item).toDomain())
              .toList() ??
          [],
      weather: WeatherRaw.fromJson(weather ?? {}).toDomain(),
    );
  }
}

extension MetricsRawMapper on MetricsRaw {
  Metrics toDomain() {
    return Metrics(
      totalStations: totalStations,
      highRiskStationsCount: highRiskStationsCount,
      peakWaterLevel: peakWaterLevel,
      peakWaterStation: peakWaterStation,
      peakWaterStationId: peakWaterStationId,
      maxRain1h: maxRain1h,
      maxRain1hStation: maxRain1hStation,
      maxRain1hStationId: maxRain1hStationId,
      maxRain24h: maxRain24h,
      maxRain24hStation: maxRain24hStation,
      maxRain24hStationId: maxRain24hStationId,
    );
  }
}

extension StationRawMapper on StationRaw {
  Station toDomain() {
    return Station(
      stationId: stationId,
      stationName: stationName,
      latitude: latitude,
      longitude: longitude,
      geohash: geohash,
      rain10m: rain10m,
      rain1h: rain1h,
      rain24h: rain24h,
      waterLevel: waterLevel,
      waterLevelDelta1h: waterLevelDelta1h,
      waterRiskLevel: waterRiskLevel,
      rainRiskLevel: rainRiskLevel,
      riskLevel: riskLevel,
      lastUpdated: DateTime.tryParse(lastUpdated) ?? DateTime.now(),
    );
  }
}

extension RoadRawMapper on RoadRaw {
  Road toDomain() {
    return Road(
      roadId: roadId,
      roadName: roadName,
      coordinates: coordinates,
      centroid: centroid,
      elevationM: elevationM,
      elevationMeters: elevationMeters,
      noahHazardLevel: noahHazardLevel,
      isFlooded: isFlooded,
      estimatedDepthCm: estimatedDepthCm,
      hazardScore: hazardScore,
      severity: severity,
      color: color,
      depthCategory: depthCategory,
      lineWeight: lineWeight,
      drivableVehicles: drivableVehicles,
      nearestStation: nearestStation,
      isNearRiver: isNearRiver,
      nationalRoute: nationalRoute,
      roadClassification: roadClassification,
      region: region,
      description: description,
    );
  }
}

extension HeatmapPointRawMapper on HeatmapPointRaw {
  HeatmapPoint toDomain() {
    return HeatmapPoint(
      lat: lat,
      lng: lng,
      intensity: intensity,
      depthCm: depthCm,
      category: category,
      radius: radius,
      isFlooded: isFlooded,
    );
  }
}

extension WeatherRawMapper on WeatherRaw {
  Weather toDomain() {
    return Weather(
      metroManilaRainMmHr: metroManilaRainMmHr,
      metroManilaRain24hMm: metroManilaRain24hMm,
      forecast3hTotalMm: forecast3hTotalMm,
      trend: trend,
      conditionLabel: conditionLabel,
    );
  }
}

extension TelemetryRawMapper on TelemetryRaw {
  Telemetry toDomain() {
    return Telemetry(
      success: success ?? false,
      scrapedAt: _parseDateTime(scrapedAt, 'scrapedAt'),
      cachedAt: _parseDateTime(cachedAt, 'cachedAt'),
      metrics: MetricsRaw.fromJson(metrics ?? {}).toDomain(),
      stations:
          stations
              ?.map((item) => StationRaw.fromJson(item).toDomain())
              .toList() ??
          [],
    );
  }
}

extension AdvisoryMapper on AdvisoryRaw {
  Advisory toDomain() {
    return Advisory(
      id: id,
      source: source,
      authorName: authorName,
      authorHandle: authorHandle,
      publishedAt: _parseDateTime(publishedAt, 'publishedAt'),
      cleanedText: cleanedText,
      severity: severity,
      passability: passability,
      depthCategory: depthCategory,
      depthInches: depthInches,
      road: road,
      landmark: landmark,
      city: city,
      coordinates: CoordinatesRaw.fromJson(coordinates).toDomain(),
      locationPins: locationPins
          .map((i) => LocationPinRaw.fromJson(i).toDomain())
          .toList(),
    );
  }
}

extension LocationPinRawMapper on LocationPinRaw {
  LocationPin toDomain() {
    return LocationPin(
      id: id,
      road: road,
      landmark: landmark,
      coordinates: CoordinatesRaw.fromJson(coordinates).toDomain(),
      depthCategory: depthCategory,
      passability: passability,
      severity: severity,
    );
  }
}

extension CoordinatesRawMapper on CoordinatesRaw {
  Coordinates toDomain() {
    return Coordinates(lat: lat, lng: lng);
  }
}
