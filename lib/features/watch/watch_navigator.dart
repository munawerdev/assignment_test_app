import 'package:assignment_test_app/features/category/category_navigator.dart';
import 'package:assignment_test_app/features/movie_detail/movie_detail_navigator.dart';
import 'package:material_ui/material_ui.dart';

import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';
import 'watch_initial_params.dart';
import 'watch_page.dart';

class WatchNavigator with MovieDetailRoute, CategoryRoute {
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
