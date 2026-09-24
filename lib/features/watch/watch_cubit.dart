import 'package:assignment_test_app/core/constants/global.dart';
import 'package:assignment_test_app/core/services/pagination_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';
import '/data/models/watch_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'watch_initial_params.dart';
import 'watch_navigator.dart';
import 'watch_state.dart';

class WatchCubit extends Cubit<WatchState> with PaginationMixin {
  final NetworkBaseApiService networkRepository;
  final WatchNavigator navigator;
  final WatchInitialParams initialParams;
  WatchCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(WatchState.initial(initialParams: initialParams));

  Future<void> watch() async {
    emit(state.copyWith(response: ApiResponse.loading()));

    final watch = await networkRepository.get<Map<String, dynamic>>(
      url: AppUrl.watch,
      queryParams: {'api_key': GlobalConstants.apiKey, 'page': 1},
    );
    watch.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) => emit(
        state.copyWith(response: ApiResponse.completed(WatchModel.fromJson(r))),
      )),
    );
  }

  Future<void> loadMore() async {
    await loadMoreData<WatchModel>(
      limit: GlobalConstants.defaultPageLimit,
      fetchData: (page, limit) async {
        final result = await networkRepository.get<Map<String, dynamic>>(
          url: AppUrl.watch,
          queryParams: {'api_key': GlobalConstants.apiKey, 'page': page},
        );
        return result.fold(
          ApiResponse.error,
          (r) => ApiResponse.completed(WatchModel.fromJson(r)),
        );
      },
      mergeData: (current, newData) =>
          current.copyWith(results: [...?current.results, ...?newData.results]),
      getCurrentCount: (data) => data.results!.length,
      getTotalCount: (data) => data.totalResults ?? 0,
    );
  }
}
