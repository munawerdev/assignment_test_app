import 'package:flutter/material.dart';
import 'dashboard_initial_params.dart';
import 'dashboard_page.dart';
import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';

class DashboardNavigator {
  DashboardNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin DashboardRoute {
void openDashboard(DashboardInitialParams initialParams) =>
navigator.push(
context: context,
        routeName: DashboardPage(cubit: getIt(param1: initialParams))
);

AppNavigator get navigator;

BuildContext get context;
}
