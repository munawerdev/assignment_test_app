import 'package:material_ui/material_ui.dart';

import 'watch_initial_params.dart';
import 'watch_page.dart';
import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';

class WatchNavigator {
  WatchNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin WatchRoute {
  void openWatch(WatchInitialParams initialParams) => navigator.push(
    context: context,
    routeName: WatchPage(cubit: getIt(param1: initialParams)),
  );

  AppNavigator get navigator;

  BuildContext get context;
}
