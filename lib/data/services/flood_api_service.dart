import 'dart:convert';

import 'package:bantay_baha/data/models/advisories_raw.dart';
import 'package:bantay_baha/data/models/flood_raw.dart';
import 'package:bantay_baha/data/models/telemetry_raw.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FloodApiService {
  const FloodApiService();

  static const Duration _requestTimeout = Duration(seconds: 20);

  final String _baseUrl = 'bahaba.nicolei.games';
  final String _floodLiveApi = '/api/flood/live';
  final String _advisories = '/api/cron/advisories';
  final String _telemetry = '/api/telemetry';

  Future<FloodRaw> fetchFloodLive({
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await http
        .get(
          Uri.https(_baseUrl, _floodLiveApi, queryParameters),
          headers: headers,
        )
        .timeout(_requestTimeout);
    _ensureSuccess(response);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return FloodRaw.fromJson(json);
  }

  Future<TelemetryRaw> fetchTelemetry({
    Map<String, dynamic>? queryParameters,
  }) async {
    final http.Response response = await http
        .get(Uri.https(_baseUrl, _telemetry, queryParameters))
        .timeout(_requestTimeout);
    _ensureSuccess(response);
    final Map<String, dynamic> json = jsonDecode(response.body);
    return TelemetryRaw.fromJson(json);
  }

  Future<AdvisoriesRaw> fetchAdvisories({
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await http
        .get(
          Uri.https(_baseUrl, _advisories, queryParameters),
          headers: headers,
        )
        .timeout(_requestTimeout);
    _ensureSuccess(response);
    final Map<String, dynamic> json = jsonDecode(response.body);
    return AdvisoriesRaw.fromJson(json);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Flood API returned HTTP ${response.statusCode}',
        response.request?.url,
      );
    }
  }
}
