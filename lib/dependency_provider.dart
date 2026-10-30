import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:flutter/material.dart';

class RepositoryProvider extends InheritedWidget {
  final FloodRepository _floodRepository;

  const RepositoryProvider({
    super.key,
    required this._floodRepository,
    required super.child,
  });

  static FloodRepository of(BuildContext context) {
    final RepositoryProvider? provider = context
        .dependOnInheritedWidgetOfExactType<RepositoryProvider>();

    assert(provider != null, 'No RepositoryProvider found in the widget tree.');

    final FloodRepository floodRepository = provider!._floodRepository;

    return floodRepository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) => false;
}
