

import 'package:bantay_baha/data/repositories/flood_repository_impl.dart';
import 'package:bantay_baha/domain/models/flood.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {

  final FloodRepository _floodRepository;

  HomeViewModel(this._floodRepository);

}

