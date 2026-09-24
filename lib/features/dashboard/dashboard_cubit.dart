

  


import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_initial_params.dart';
import 'dashboard_navigator.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardNavigator navigator;
  final DashboardInitialParams initialParams;
DashboardCubit(
  this.initialParams,
      this.navigator)
   : super(DashboardState.initial(initialParams:initialParams));

}
