import 'dart:convert';

import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:http/http.dart' as http;


class FloodApiService {
  const FloodApiService();

  final String _baseUrl = 'https://bahaba.nicolei.games';
  final String _floodLiveApi = '/api/flood/live';

  Future<FloodRaw> fetchFloodLive() async {
    final http.Response response = await http.get(
      Uri.https(_baseUrl, _floodLiveApi),
    );

    final Map<String, dynamic> json = jsonDecode(
      utf8.decode(response.bodyBytes),
    );
    return FloodRaw.fromJson(json);
  }
}
