import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/repositories/network/network_base_api_service.dart';
import 'media_library_initial_params.dart';
import 'media_library_navigator.dart';
import 'media_library_state.dart';

class MediaLibraryCubit extends Cubit<MediaLibraryState> {
  final NetworkBaseApiService networkRepository;
  final MediaLibraryNavigator navigator;
  final MediaLibraryInitialParams initialParams;
  MediaLibraryCubit(this.initialParams, this.networkRepository, this.navigator)
    : super(MediaLibraryState.initial(initialParams: initialParams));
}
