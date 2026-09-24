import 'package:assignment_test_app/core/utils/app_images.dart';
import 'package:assignment_test_app/features/home/home_initial_params.dart';
import 'package:assignment_test_app/features/home/home_page.dart';
import 'package:assignment_test_app/features/media_library/media_library_initial_params.dart';
import 'package:assignment_test_app/features/media_library/media_library_page.dart';
import 'package:assignment_test_app/features/more/more_initial_params.dart';
import 'package:assignment_test_app/features/more/more_page.dart';
import 'package:assignment_test_app/features/watch/watch_initial_params.dart';
import 'package:assignment_test_app/features/watch/watch_page.dart';
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
    WatchPage(cubit: getIt(param1: const WatchInitialParams())),
    MediaLibraryPage(cubit: getIt(param1: const MediaLibraryInitialParams())),
    MorePage(cubit: getIt(param1: const MoreInitialParams())),
  ];
}
