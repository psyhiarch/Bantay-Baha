

import 'dart:collection';

import 'package:bantay_baha/data/repositories/flood_repository_impl.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/models/station.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {

  final FloodRepository _floodRepository;
  Flood? _flood;
  List<Station>? _stations;
  UnmodifiableListView<Station> get stations => UnmodifiableListView(_stations ?? []);

  HomeViewModel(this._floodRepository);

  Future<void> initFlood() async {
    _flood = await _floodRepository.getFloodLive();
    _stations = _flood?.stations;
    notifyListeners();
  }

}

