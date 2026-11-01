import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/shell_scaffold.dart';
import 'package:bantay_baha/ui/home/home_view.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

GoRouter _goRouter = GoRouter(
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ChangeNotifierProvider.value(
            value: getIt<HomeViewModel>(),
            child: const HomeView(),
          ),
        ),
      ],
      builder: (context, state, child) => ShellScaffold(child: child),
    ),
  ],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapLibreMap.preWarm();
  setupLocator();
  runApp(MaterialApp.router(routerConfig: _goRouter));
}
