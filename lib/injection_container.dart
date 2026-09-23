import 'package:get_it/get_it.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import '/domain/usecases/local/check_for_existing_user_use_case.dart';
import 'config/navigation/app_navigator.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/show/show/show.dart';
import 'data/datasources/theme/theme_data_source.dart';
// import '/data/datasources/internet_connectivity/internet_connectivity_checker_data_sources.dart';

import 'data/datasources/user/user_data_sources.dart';
import 'data/repositories/local/local_storage_repository.dart';
import 'data/repositories/network/dio/dio_network_repository.dart';
import 'data/repositories/network/errors/api_error_handler.dart';
import 'domain/repositories/local/local_storage_base_api_service.dart';
import 'domain/usecases/theme/get_theme_use_case.dart';
import 'domain/usecases/theme/update_theme_use_case.dart';
import 'domain/usecases/user/user_use_cases.dart';
/*
************************ BottomNav ************************
*/
import 'features/bottom_nav/bottom_nav_cubit.dart';
import 'features/bottom_nav/bottom_nav_initial_params.dart';
import 'features/bottom_nav/bottom_nav_navigator.dart';
import 'features/home/home_cubit.dart';
import 'features/home/home_initial_params.dart';
/*
************************ Home ************************
*/
import 'features/home/home_navigator.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  getIt.registerSingleton<UserDataSources>(UserDataSources());
  getIt.registerSingleton<LocalStorageBaseApiService>(LocalStorageRepository());
  getIt.registerSingleton<UserUseCases>(UserUseCases(getIt(), getIt()));
  getIt.registerSingleton<CheckForExistingUserUseCase>(
    CheckForExistingUserUseCase(getIt(), getIt()),
  );
  getIt.registerSingleton<ApiErrorHandler>(const ApiErrorHandler());
  getIt.registerSingleton<NetworkBaseApiService>(
    DioNetworkRepository(getIt(), getIt()),
  );
  /*
************************ Theme ************************
*/

  getIt.registerSingleton<ThemeDataSources>(ThemeDataSources());
  getIt.registerSingleton<GetThemeUseCase>(GetThemeUseCase(getIt(), getIt()));
  getIt.registerSingleton<UpdateThemeUseCase>(
    UpdateThemeUseCase(getIt(), getIt()),
  );
  //  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<Show>(Show());

  // getIt.registerSingleton<InternetConnectivityCheckerDataSources>(
  //     InternetConnectivityCheckerDataSources(getIt(), getIt()));

  /*
************************ Bottom Nav ************************
*/
  getIt.registerSingleton<BottomNavNavigator>(BottomNavNavigator(getIt()));
  getIt.registerFactoryParam<BottomNavCubit, BottomNavInitialParams, dynamic>(
    (params, _) => BottomNavCubit(params, getIt()),
  );
  /*
************************ Home ************************
*/
  getIt.registerSingleton<HomeNavigator>(HomeNavigator(getIt()));
  getIt.registerFactoryParam<HomeCubit, HomeInitialParams, dynamic>(
    (params, _) => HomeCubit(params, getIt(), getIt())..home(),
  );
}
