import 'package:bantay_baha/core/app_restart.dart';
import 'package:bantay_baha/core/locator.dart';
import 'package:bantay_baha/data/services/background_service.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/ui/advisories/advisories_view.dart';
import 'package:bantay_baha/ui/home/home_view.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/map/map_view.dart';
import 'package:bantay_baha/ui/settings/settings_view.dart';
import 'package:bantay_baha/ui/theme/app_theme.dart';
import 'package:bantay_baha/ui/theme/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:provider/provider.dart';

GoRouter _createGoRouter() => GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ChangeNotifierProvider<HomeViewModel>(
            create: (_) => getIt<HomeViewModel>()..init(),
            child: _AppShell(navigationShell: navigationShell),
          ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeView()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => MapView(
                selectedStationId:
                    state.uri.queryParameters['stationId'] ??
                    state.extra as String?,
                focusRequestId: state.uri.queryParameters['focus'],
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/advisories',
              builder: (context, state) => const AdvisoriesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper_rounded),
            label: 'Advisories',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _goRouter = _createGoRouter();

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

  @override
  void dispose() {
    _goRouter.dispose();
    super.dispose();
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
    ChangeNotifierProvider.value(
      value: themeController,
      child: const AppRestart(child: MyApp()),
    ),
  );
}
