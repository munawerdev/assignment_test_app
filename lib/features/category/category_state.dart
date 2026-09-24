
import '/data/models/category_model.dart';
import 'category_initial_params.dart';
import '/config/response/api_response.dart';

class CategoryState {
  final ApiResponse<CategoryModel> response;

  CategoryState({required this.response});
  factory CategoryState.initial({required CategoryInitialParams initialParams}) =>
      CategoryState(response: ApiResponse.initial(CategoryModel.fromJson({})));
  CategoryState copyWith(
          {ApiResponse<CategoryModel>? response}) =>
      CategoryState(
          response: response ?? this.response);
}



 