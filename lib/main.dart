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

final GoRouter _goRouter = GoRouter(
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
              builder: (context, state) =>
                  MapView(selectedStationId: state.extra as String?),
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
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: navigationShell),
          SafeArea(
            top: false,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              child: SizedBox(
                height: 64,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _navigationDestination(
                            context,
                            index: 0,
                            label: 'Home',
                            icon: Icons.home_outlined,
                            selectedIcon: Icons.home_rounded,
                          ),
                        ),
                        Expanded(
                          child: _navigationDestination(
                            context,
                            index: 1,
                            label: 'Map',
                            icon: Icons.map_outlined,
                            selectedIcon: Icons.map_rounded,
                          ),
                        ),

                        Expanded(
                          child: _navigationDestination(
                            context,
                            index: 2,
                            label: 'Advisories',
                            icon: Icons.newspaper_outlined,
                            selectedIcon: Icons.newspaper_rounded,
                          ),
                        ),

                        Expanded(
                          child: _navigationDestination(
                            context,
                            index: 3,
                            label: 'Settings',
                            icon: Icons.settings_outlined,
                            selectedIcon: Icons.settings_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationDestination(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    final theme = Theme.of(context);
    final selected = navigationShell.currentIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              size: 21,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 1),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
