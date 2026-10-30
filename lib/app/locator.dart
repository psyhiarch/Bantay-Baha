import 'package:bantay_baha/data/repositories/flood_repository_impl.dart';
import 'package:bantay_baha/data/services/flood_api_service.dart';
import 'package:bantay_baha/domain/repositories/flood_repository.dart';
import 'package:bantay_baha/ui/home/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<FloodApiService>(FloodApiService());
  getIt.registerLazySingleton<FloodRepository>(
    () => FloodRepositoryImpl(getIt<FloodApiService>()),
  );
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(getIt<FloodRepository>()),
  );
}
