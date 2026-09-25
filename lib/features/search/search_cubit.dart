import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import 'search_initial_params.dart';
import 'search_navigator.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final NetworkBaseApiService networkRepository;
  final SearchNavigator navigator;
  final SearchInitialParams initialParams;
  SearchCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(SearchState.initial(initialParams: initialParams));
}
