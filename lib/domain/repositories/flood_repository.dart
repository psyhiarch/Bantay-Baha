import 'package:bantay_baha/domain/models/advisory.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/telemetry.dart';

abstract class FloodRepository {

  Future<Flood?> getFloodLive();
  Future<Telemetry?> getTelemetry();
  Future<List<Advisory>?> getAdvisories();
}