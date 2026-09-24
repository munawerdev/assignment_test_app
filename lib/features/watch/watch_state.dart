import '/config/response/api_response.dart';
import '/data/models/watch_model.dart';
import 'watch_initial_params.dart';

class WatchState {
  final ApiResponse<WatchModel> response;

  WatchState({required this.response});
  factory WatchState.initial({required WatchInitialParams initialParams}) =>
      WatchState(response: ApiResponse.initial(WatchModel.fromJson({})));
  WatchState copyWith({ApiResponse<WatchModel>? response}) =>
      WatchState(response: response ?? this.response);
}
