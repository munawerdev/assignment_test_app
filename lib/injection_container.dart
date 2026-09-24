/*
************************ MovieDetail ************************
*/
/*
************************ Dashboard ************************
*/
/*
************************ More ************************
*/
import 'package:assignment_test_app/data/repositories/local/local_storage_repository.dart';
import 'package:assignment_test_app/domain/repositories/local/local_storage_base_api_service.dart';
import 'package:get_it/get_it.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import '/domain/usecases/local/check_for_existing_user_use_case.dart';
import 'config/navigation/app_navigator.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/show/show/show.dart';
// import '/data/datasources/internet_connectivity/internet_connectivity_checker_data_sources.dart';

import 'data/datasources/user/user_data_sources.dart';
import 'data/repositories/network/dio/dio_network_repository.dart';
import 'data/repositories/network/errors/api_error_handler.dart';
import 'domain/usecases/user/user_use_cases.dart';
/*
************************ BottomNav ************************
*/
import 'features/bottom_nav/bottom_nav_cubit.dart';
import 'features/bottom_nav/bottom_nav_initial_params.dart';
import 'features/bottom_nav/bottom_nav_navigator.dart';
import 'features/dashboard/dashboard_cubit.dart';
import 'features/dashboard/dashboard_initial_params.dart';
import 'features/dashboard/dashboard_navigator.dart';
/*
************************ MediaLibrary ************************
*/
import 'features/media_library/media_library_cubit.dart';
import 'features/media_library/media_library_initial_params.dart';
import 'features/media_library/media_library_navigator.dart';
import 'features/more/more_cubit.dart';
import 'features/more/more_initial_params.dart';
import 'features/more/more_navigator.dart';
import 'features/movie_detail/movie_detail_cubit.dart';
import 'features/movie_detail/movie_detail_initial_params.dart';
import 'features/movie_detail/movie_detail_navigator.dart';
/*
************************ Watch ************************
*/
import 'features/watch/watch_cubit.dart';
import 'features/watch/watch_initial_params.dart';
import 'features/watch/watch_navigator.dart';

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

  getIt.registerSingleton<Show>(Show());

  /*
************************ Bottom Nav ************************
*/
  getIt.registerSingleton<BottomNavNavigator>(BottomNavNavigator(getIt()));
  getIt.registerFactoryParam<BottomNavCubit, BottomNavInitialParams, dynamic>(
    (params, _) => BottomNavCubit(params, getIt()),
  );

  /*
************************ Watch ************************
*/
  getIt.registerSingleton<WatchNavigator>(WatchNavigator(getIt()));
  getIt.registerFactoryParam<WatchCubit, WatchInitialParams, dynamic>(
    (params, _) => WatchCubit(params, getIt(), getIt())..watch(),
  );

  /*
************************ MediaLibrary ************************
*/
  getIt.registerSingleton<MediaLibraryNavigator>(
    MediaLibraryNavigator(getIt()),
  );
  getIt.registerFactoryParam<
    MediaLibraryCubit,
    MediaLibraryInitialParams,
    dynamic
  >((params, _) => MediaLibraryCubit(params, getIt(), getIt()));

  /*
************************ More ************************
*/
  getIt.registerSingleton<MoreNavigator>(MoreNavigator(getIt()));
  getIt.registerFactoryParam<MoreCubit, MoreInitialParams, dynamic>(
    (params, _) => MoreCubit(params, getIt()),
  );
  /*
************************ Dashboard ************************
*/
  getIt.registerSingleton<DashboardNavigator>(DashboardNavigator(getIt()));
  getIt.registerFactoryParam<DashboardCubit, DashboardInitialParams, dynamic>(
    (params, _) => DashboardCubit(params, getIt()),
  );
  /*
************************ MovieDetail ************************
*/
  getIt.registerSingleton<MovieDetailNavigator>(MovieDetailNavigator(getIt()));
  getIt.registerFactoryParam<
    MovieDetailCubit,
    MovieDetailInitialParams,
    dynamic
  >((params, _) => MovieDetailCubit(params, getIt(), getIt())..movieDetail());
}
