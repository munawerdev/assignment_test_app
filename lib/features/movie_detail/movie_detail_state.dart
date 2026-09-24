import '/config/response/api_response.dart';
import '/data/models/movie_detail_model.dart';
import 'movie_detail_initial_params.dart';

class MovieDetailState {
  final ApiResponse<MovieDetailModel> response;

  MovieDetailState({required this.response});
  factory MovieDetailState.initial({
    required MovieDetailInitialParams initialParams,
  }) => MovieDetailState(
    response: ApiResponse.initial(MovieDetailModel.fromJson({})),
  );
  MovieDetailState copyWith({ApiResponse<MovieDetailModel>? response}) =>
      MovieDetailState(response: response ?? this.response);
}
