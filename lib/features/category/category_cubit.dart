import 'package:assignment_test_app/features/search/search_initial_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import 'category_initial_params.dart';
import 'category_navigator.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final NetworkBaseApiService networkRepository;
  final CategoryNavigator navigator;
  final CategoryInitialParams initialParams;
  CategoryCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(CategoryState.initial(initialParams: initialParams));

  void goSearch() => navigator.openSearch(const SearchInitialParams());
}
