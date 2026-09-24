
import '/data/models/search_model.dart';
import 'search_initial_params.dart';
import '/config/response/api_response.dart';

class SearchState {
  final ApiResponse<SearchModel> response;

  SearchState({required this.response});
  factory SearchState.initial({required SearchInitialParams initialParams}) =>
      SearchState(response: ApiResponse.initial(SearchModel.fromJson({})));
  SearchState copyWith(
          {ApiResponse<SearchModel>? response}) =>
      SearchState(
          response: response ?? this.response);
}



 