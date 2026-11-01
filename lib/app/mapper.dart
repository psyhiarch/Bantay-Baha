
// import 'package:bantay_baha/data/models/flood_raw.dart';
// import 'package:bantay_baha/domain/models/flood.dart';
// import 'package:bantay_baha/domain/models/metrics.dart';
// import 'package:bantay_baha/domain/models/station.dart';

// extension FloodRawMapper on FloodRaw {
//   Flood toDomain() {
//     final DateTime calculatedAtDt = DateTime.parse(calculatedAt);
//     final DateTime scrapedAtDt = DateTime.parse(scrapedAt);
//     final List<Station> stationsL = stations.map((i) => Station)
//     return Flood(
//       success: success, 
//       calculatedAt: calculatedAtDt, 
//       scrapedAt: scrapedAtDt, 
//       metrics: Metrics.fromJson(metrics), 
//       stations: stations, 
//       roads: roads, 
//       heatmapPoints: heatmapPoints, 
//       weather: weather
//       );
//   }
// }
