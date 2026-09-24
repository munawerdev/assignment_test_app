
import 'package:flutter_bloc/flutter_bloc.dart';
import 'media_library_initial_params.dart';
import 'media_library_navigator.dart';
import 'media_library_state.dart';
import '/data/models/media_library_model.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import '/config/response/api_response.dart';
import '/core/utils/app_url.dart';

class MediaLibraryCubit extends Cubit<MediaLibraryState> {
  final NetworkBaseApiService networkRepository;
  final MediaLibraryNavigator navigator;
  final MediaLibraryInitialParams initialParams;
MediaLibraryCubit(
  this.initialParams,
      this.networkRepository,
      this.navigator)
   : super(MediaLibraryState.initial(initialParams:initialParams));

Future<void> mediaLibrary({bool? showLoading = false}) async {
  if (showLoading!) {
    emit(state.copyWith(response: ApiResponse.loading()));
  }
    final mediaLibrary = await networkRepository.get<Map<String, dynamic>>(url: AppUrl.mediaLibrary);
    mediaLibrary.fold(
      (l) => emit(state.copyWith(response: ApiResponse.error(l))),
      ((r) =>emit(state.copyWith(response: ApiResponse.completed(MediaLibraryModel.fromJson(r))))));
  }  
}


  

