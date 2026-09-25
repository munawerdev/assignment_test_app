import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/response/api_response.dart';
import '/config/response/status.dart';
import '/core/constants/global.dart';
import '/core/utils/app_url.dart';
import '/data/models/watch_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/features/bottom_nav/bottom_nav_initial_params.dart';
import '/features/movie_detail/movie_detail_initial_params.dart';
import 'search_initial_params.dart';
import 'search_navigator.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final NetworkBaseApiService networkRepository;
  final SearchNavigator navigator;
  final SearchInitialParams initialParams;
  SearchCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(SearchState.initial(initialParams: initialParams));

  int _requestId = 0;
  WatchModel? _popularMovies;

  Future<void> loadPopularMovies() async {
    if (_popularMovies != null) {
      showPopularMovies();
      return;
    }
    if (state.response.status == Status.LOADING && state.query.isEmpty) {
      return;
    }
    final requestId = ++_requestId;
    emit(state.copyWith(query: '', response: ApiResponse.loading()));
    final result = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.popular,
      queryParams: {'api_key': GlobalConstants.apiKey, 'page': 1},
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(state.copyWith(response: ApiResponse.error(failure))),
      (json) {
        _popularMovies = WatchModel.fromJson(json);
        emit(state.copyWith(response: ApiResponse.completed(_popularMovies!)));
      },
    );
  }

  void showPopularMovies() {
    if (_popularMovies != null) {
      ++_requestId;
      emit(
        state.copyWith(
          query: '',
          response: ApiResponse.completed(_popularMovies!),
        ),
      );
      return;
    }
    if (state.query.isNotEmpty || state.response.status != Status.LOADING) {
      loadPopularMovies();
    }
  }

  Future<void> search(String rawQuery) async {
    final query = rawQuery.trim();
    if (query.isEmpty) {
      showPopularMovies();
      return;
    }
    final requestId = ++_requestId;
    emit(state.copyWith(query: query, response: ApiResponse.loading()));
    final result = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.search,
      queryParams: {'api_key': GlobalConstants.apiKey, 'query': query},
    );
    if (isClosed || requestId != _requestId) return;
    result.fold(
      (failure) => emit(state.copyWith(response: ApiResponse.error(failure))),
      (json) => emit(
        state.copyWith(
          response: ApiResponse.completed(WatchModel.fromJson(json)),
        ),
      ),
    );
  }

  void openMovie(Result result) =>
      navigator.openMovieDetail(MovieDetailInitialParams(result: result));

  void openTab(int index) =>
      navigator.openBottomNav(BottomNavInitialParams(selectedIndex: index));
}
