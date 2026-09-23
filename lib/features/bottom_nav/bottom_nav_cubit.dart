import 'package:assignment_test_app/core/utils/app_images.dart';
import 'package:assignment_test_app/features/home/home_initial_params.dart';
import 'package:assignment_test_app/features/home/home_page.dart';
import 'package:assignment_test_app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'bottom_nav_initial_params.dart';
import 'bottom_nav_navigator.dart';
import 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  final BottomNavNavigator navigator;
  final BottomNavInitialParams initialParams;
  BottomNavCubit(this.initialParams, this.navigator)
    : super(BottomNavState.initial(initialParams: initialParams)) {
    setSelectedIndex(initialParams.selectedIndex);
  }

  void setSelectedIndex(int index) =>
      emit(state.copyWith(selectedIndex: index));

  final List<String> tabLabels = <String>[
    'Dashboard',
    'Watch',
    'Media Library',
    'More',
  ];
  final List<String> tabIcons = <String>[
    AppImages.dashboard,
    AppImages.watch,
    AppImages.mediaLibrary,
    AppImages.more,
  ];

  final List<Widget> pages = <Widget>[
    HomePage(cubit: getIt(param1: const HomeInitialParams())),
    const SizedBox(),
    HomePage(cubit: getIt(param1: const HomeInitialParams())),
    HomePage(cubit: getIt(param1: const HomeInitialParams())),
  ];
}
