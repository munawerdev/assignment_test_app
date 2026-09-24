import '/config/response/api_response.dart';
import '/data/models/watch_model.dart';
import 'watch_initial_params.dart';

class WatchState {
  final ApiResponse<WatchModel> response;
  final bool isLoadingMore;

  WatchState({required this.response, required this.isLoadingMore});
  factory WatchState.initial({required WatchInitialParams initialParams}) =>
      WatchState(
        response: ApiResponse.initial(WatchModel.fromJson({})),
        isLoadingMore: false,
      );
  WatchState copyWith({
    ApiResponse<WatchModel>? response,
    bool? isLoadingMore,
  }) => WatchState(
    response: response ?? this.response,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );
}
