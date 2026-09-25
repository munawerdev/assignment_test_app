import '/config/response/api_response.dart';
import '/data/models/watch_model.dart';
import 'search_initial_params.dart';

class SearchState {
  final String query;
  final ApiResponse<WatchModel> response;

  SearchState({required this.query, required this.response});
  factory SearchState.initial({required SearchInitialParams initialParams}) =>
      SearchState(
        query: '',
        response: ApiResponse.initial(WatchModel.fromJson({})),
      );
  SearchState copyWith({String? query, ApiResponse<WatchModel>? response}) =>
      SearchState(
        query: query ?? this.query,
        response: response ?? this.response,
      );
}
