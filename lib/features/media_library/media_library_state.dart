
import '/data/models/media_library_model.dart';
import 'media_library_initial_params.dart';
import '/config/response/api_response.dart';

class MediaLibraryState {
  final ApiResponse<MediaLibraryModel> response;

  MediaLibraryState({required this.response});
  factory MediaLibraryState.initial({required MediaLibraryInitialParams initialParams}) =>
      MediaLibraryState(response: ApiResponse.initial(MediaLibraryModel.fromJson({})));
  MediaLibraryState copyWith(
          {ApiResponse<MediaLibraryModel>? response}) =>
      MediaLibraryState(
          response: response ?? this.response);
}



 