import 'package:bantay_baha/core/mapper.dart';
import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';

class FloodRepositoryImpl implements FloodRepository {
  final FloodApiService _floodApiService;

  const FloodRepositoryImpl(this._floodApiService);

  @override
  Future<Flood> getFloodLive() async {
    final FloodRaw floodRaw = await _floodApiService.fetchFloodLive();
    final Flood flood = floodRaw.toDomain();
    return flood;
  }
}
