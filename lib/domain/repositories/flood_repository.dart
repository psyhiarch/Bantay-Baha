import 'package:bantay_baha/domain/models/flood.dart';

abstract class FloodRepository {

  Future<Flood?> getFloodLive();
}