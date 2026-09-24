import 'package:assignment_test_app/core/constants/global.dart';
import 'package:assignment_test_app/features/movie_detail/movie_detail_initial_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';
import '/data/models/watch_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'watch_initial_params.dart';
import 'watch_navigator.dart';
import 'watch_state.dart';

class WatchCubit extends Cubit<WatchState> {
  final NetworkBaseApiService networkRepository;
  final WatchNavigator navigator;
  final WatchInitialParams initialParams;
  WatchCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(WatchState.initial(initialParams: initialParams));

  Future<void> watch() async {
    emit(state.copyWith(response: ApiResponse.loading()));

    final watch = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.watch,
      queryParams: {'api_key': GlobalConstants.apiKey},
    );
    watch.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) => emit(
        state.copyWith(response: ApiResponse.completed(WatchModel.fromJson(r))),
      )),
    );
  }

  void goMovieDetailPage({required Result result}) =>
      navigator.openMovieDetail(MovieDetailInitialParams(result: result));
}
