import 'package:bantay_baha/data/repositories/flood_repository_impl.dart';
import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/data/services/local_notification_service.dart';
import 'package:bantay_baha/data/services/station_history_service.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:bantay_baha/ui/theme/app_theme_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<FloodApiService>(FloodApiService());
  getIt.registerSingleton<LocalNotificationService>(LocalNotificationService());
  getIt.registerSingleton<StationHistoryService>(StationHistoryService());
  getIt.registerSingleton<AppThemeController>(AppThemeController());
  getIt.registerLazySingleton<FloodRepository>(
    () => FloodRepositoryImpl(getIt<FloodApiService>()),
  );
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(
      floodRepository: getIt<FloodRepository>(),
      stationHistoryService: getIt<StationHistoryService>(),
    ),
  );
}
