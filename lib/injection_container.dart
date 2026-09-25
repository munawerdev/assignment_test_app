import 'package:get_it/get_it.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import 'config/navigation/app_navigator.dart';
import 'data/repositories/network/dio/dio_network_repository.dart';
import 'data/repositories/network/errors/api_error_handler.dart';
/*
************************ BottomNav ************************
*/
import 'features/bottom_nav/bottom_nav_cubit.dart';
import 'features/bottom_nav/bottom_nav_initial_params.dart';
import 'features/bottom_nav/bottom_nav_navigator.dart';
import 'features/category/category_cubit.dart';
import 'features/category/category_initial_params.dart';
import 'features/category/category_navigator.dart';
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
************************ Search ************************
*/
import 'features/search/search_cubit.dart';
import 'features/search/search_initial_params.dart';
import 'features/search/search_navigator.dart';
/*
************************ Watch ************************
*/
import 'features/watch/watch_cubit.dart';
import 'features/watch/watch_initial_params.dart';
import 'features/watch/watch_navigator.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AppNavigator>(AppNavigator());

  getIt.registerSingleton<ApiErrorHandler>(const ApiErrorHandler());
  getIt.registerSingleton<NetworkBaseApiService>(DioNetworkRepository(getIt()));

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
  /*
************************ Search ************************
*/
  getIt.registerSingleton<SearchNavigator>(SearchNavigator(getIt()));
  getIt.registerFactoryParam<SearchCubit, SearchInitialParams, dynamic>(
    (params, _) => SearchCubit(params, getIt(), getIt()),
  );

  /*
************************ Category ************************
*/
  getIt.registerSingleton<CategoryNavigator>(CategoryNavigator(getIt()));
  getIt.registerFactoryParam<CategoryCubit, CategoryInitialParams, dynamic>(
    (params, _) => CategoryCubit(params, getIt(), getIt()),
  );
}
