
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_initial_params.dart';
import 'category_navigator.dart';
import 'category_state.dart';
import '/data/models/category_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final NetworkBaseApiService networkRepository;
  final CategoryNavigator navigator;
  final CategoryInitialParams initialParams;
CategoryCubit(
  this.initialParams,
      this.networkRepository,
      this.navigator)
   : super(CategoryState.initial(initialParams:initialParams));

Future<void> category({bool? showLoading = false}) async {
  if (showLoading!) {
    emit(state.copyWith(response: ApiResponse.loading()));
  }
    final category = await networkRepository.get<Map<String, dynamic>>(url: AppUrl.category);
    category.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) =>emit(state.copyWith(response: ApiResponse.completed(CategoryModel.fromJson(r))))));
  }  
}


  

