import 'package:flutter/material.dart';
import 'category_initial_params.dart';
import 'category_page.dart';
import '/config/navigation/app_navigator.dart';
import '/injection_container.dart';

class CategoryNavigator {
  CategoryNavigator(this.navigator);
  @override
  late BuildContext context;
  @override
  AppNavigator navigator;
}

mixin CategoryRoute {
void openCategory(CategoryInitialParams initialParams) =>
navigator.push(
context: context,
        routeName: CategoryPage(cubit: getIt(param1: initialParams))
);

AppNavigator get navigator;

BuildContext get context;
}
