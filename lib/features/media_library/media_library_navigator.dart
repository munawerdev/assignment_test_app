import 'package:material_ui/material_ui.dart';

import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';
import 'media_library_initial_params.dart';
import 'media_library_page.dart';

class MediaLibraryNavigator {
  MediaLibraryNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin MediaLibraryRoute {
  void openMediaLibrary(MediaLibraryInitialParams initialParams) =>
      navigator.push(
        context: context,
        routeName: MediaLibraryPage(cubit: getIt(param1: initialParams)),
      );

  AppNavigator get navigator;

  BuildContext get context;
}
