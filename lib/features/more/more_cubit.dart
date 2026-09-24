

  


import 'package:flutter_bloc/flutter_bloc.dart';
import 'more_initial_params.dart';
import 'more_navigator.dart';
import 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final MoreNavigator navigator;
  final MoreInitialParams initialParams;
MoreCubit(
  this.initialParams,
      this.navigator)
   : super(MoreState.initial(initialParams:initialParams));

}
