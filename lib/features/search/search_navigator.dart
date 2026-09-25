import 'package:flutter/material.dart';

import '/config/navigation/app_navigator.dart';
import '/features/bottom_nav/bottom_nav_navigator.dart';
import '/features/movie_detail/movie_detail_navigator.dart';
import '/injection_container.dart';
import 'search_initial_params.dart';
import 'search_page.dart';

class SearchNavigator with MovieDetailRoute, BottomNavRoute {
  SearchNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin SearchRoute {
  void openSearch(SearchInitialParams initialParams) => navigator.push(
    context: context,
    routeName: SearchPage(cubit: getIt(param1: initialParams)),
  );

  AppNavigator get navigator;

  BuildContext get context;
}
