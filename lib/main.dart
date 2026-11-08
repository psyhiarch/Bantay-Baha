import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/data/services/background_service.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/ui/advisories/advisories_view.dart';
import 'package:bantay_baha/ui/home/home_view.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/map/map_route_args.dart';
import 'package:bantay_baha/ui/map/map_view.dart';
import 'package:bantay_baha/ui/settings/settings_view.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:bantay_baha/ui/theme/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

GoRouter _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: ChangeNotifierProvider(
            create: (_) => getIt<HomeViewModel>()..init(),
            child: const HomeView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: '/advisories',
          pageBuilder: (context, state) {
            final model = state.extra! as HomeViewModel;
            return CustomTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider.value(
                value: model,
                child: const AdvisoriesView(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            final args = state.extra! as MapRouteArgs;
            return CustomTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider.value(
                value: args.model,
                child: MapView(selectedStationId: args.selectedStationId),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SettingsView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeController>(
      builder: (context, themeController, _) => MaterialApp.router(
        title: 'Bantay Baha',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode,
        routerConfig: _goRouter,
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MapLibreMap.preWarm();
  setupLocator();
  final notificationService = getIt<LocalNotificationService>();
  await notificationService.initialize();
  final themeController = getIt<AppThemeController>();
  await themeController.load();
  await initializeBackgroundAlerts();
  if (await notificationService.notificationsEnabled()) {
    await schedulePeriodicTask();
  }
  runApp(
    ChangeNotifierProvider.value(value: themeController, child: const MyApp()),
  );
}
