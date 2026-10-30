

import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/domain/models/flood.dart';

abstract class FloodRepository {

  Future<Flood> getFloodLive();
}