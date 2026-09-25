import 'package:assignment_test_app/core/constants/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart' show SnackBar, Text;

import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';
import '/data/models/movie_detail_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'movie_detail_initial_params.dart';
import 'movie_detail_navigator.dart';
import 'movie_detail_state.dart';
import 'trailer_player_page.dart';

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
    if (isClosed) return;
    movieDetail.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) => emit(
        state.copyWith(
          response: ApiResponse.completed(MovieDetailModel.fromJson(r)),
        ),
      )),
    );
  }

  Future<void> watchTrailer() async {
    final response = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.movieVideos(initialParams.result.id.toString()),
      queryParams: {'api_key': GlobalConstants.apiKey},
    );
    if (isClosed) return;
    response.fold((_) => _showTrailerUnavailable(), (json) {
      final videos = (json['results'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MovieVideoModel.fromJson)
          .where(
            (video) =>
                video.site?.toLowerCase() == 'youtube' &&
                (video.key?.isNotEmpty ?? false),
          )
          .toList();
      videos.sort((a, b) => _trailerRank(a).compareTo(_trailerRank(b)));
      if (videos.isEmpty) {
        _showTrailerUnavailable();
        return;
      }
      navigator.navigator.push(
        context: navigator.context,
        routeName: TrailerPlayerPage(videoId: videos.first.key!),
      );
    });
  }

  int _trailerRank(MovieVideoModel video) {
    final type = video.type?.toLowerCase();
    if (type == 'trailer' && video.official == true) return 0;
    if (type == 'trailer') return 1;
    if (type == 'teaser') return 2;
    return 3;
  }

  void _showTrailerUnavailable() {
    final messenger = GlobalConstants.scaffoldMessengerKey.currentState;
    messenger?.showSnackBar(
      const SnackBar(content: Text('No trailer is available for this movie.')),
    );
  }
}
