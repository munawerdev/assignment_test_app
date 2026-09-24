import 'package:material_ui/material_ui.dart';

import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';
import 'more_initial_params.dart';
import 'more_page.dart';

class MoreNavigator {
  MoreNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin MoreRoute {
  void openMore(MoreInitialParams initialParams) => navigator.push(
    context: context,
    routeName: MorePage(cubit: getIt(param1: initialParams)),
  );

  AppNavigator get navigator;

  BuildContext get context;
}
