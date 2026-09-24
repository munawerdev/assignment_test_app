import 'package:assignment_test_app/core/constants/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';
import '/data/models/movie_detail_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'movie_detail_initial_params.dart';
import 'movie_detail_navigator.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final NetworkBaseApiService networkRepository;
  final MovieDetailNavigator navigator;
  final MovieDetailInitialParams initialParams;
  MovieDetailCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(MovieDetailState.initial(initialParams: initialParams));

  Future<void> movieDetail() async {
    emit(state.copyWith(response: ApiResponse.loading()));

    final movieDetail = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.movieDetail(initialParams.result.id.toString()),
      queryParams: {'api_key': GlobalConstants.apiKey},
    );
    movieDetail.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) => emit(
        state.copyWith(
          response: ApiResponse.completed(MovieDetailModel.fromJson(r)),
        ),
      )),
    );
  }
}
