
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_initial_params.dart';
import 'search_navigator.dart';
import 'search_state.dart';
import '/data/models/search_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';

class SearchCubit extends Cubit<SearchState> {
  final NetworkBaseApiService networkRepository;
  final SearchNavigator navigator;
  final SearchInitialParams initialParams;
SearchCubit(
  this.initialParams,
      this.networkRepository,
      this.navigator)
   : super(SearchState.initial(initialParams:initialParams));

Future<void> search({bool? showLoading = false}) async {
  if (showLoading!) {
    emit(state.copyWith(response: ApiResponse.loading()));
  }
    final search = await networkRepository.get<Map<String, dynamic>>(url: AppUrl.search);
    search.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) =>emit(state.copyWith(response: ApiResponse.completed(SearchModel.fromJson(r))))));
  }  
}


  

