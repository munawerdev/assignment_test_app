import 'package:material_ui/material_ui.dart';

import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';
import 'movie_detail_initial_params.dart';
import 'movie_detail_page.dart';

class MovieDetailNavigator {
  MovieDetailNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin MovieDetailRoute {
  void openMovieDetail(MovieDetailInitialParams initialParams) =>
      navigator.push(
        context: context,
        routeName: MovieDetailPage(cubit: getIt(param1: initialParams)),
      );

  AppNavigator get navigator;

  BuildContext get context;
}
