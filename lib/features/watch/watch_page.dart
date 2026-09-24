import 'package:assignment_test_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'watch_cubit.dart';

class WatchPage extends StatefulWidget {
  final WatchCubit cubit;

  const WatchPage({super.key, required this.cubit});

  @override
  State<WatchPage> createState() => _WatchState();
}

class _WatchState extends State<WatchPage> {
  WatchCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(showLeading: false),
      // body: RefreshIndicator.adaptive(
      //   onRefresh: cubit.watch,
      //   child: BlocBuilder(
      //     bloc: cubit,
      //     builder: (context, state) {
      //       state as WatchState;
      //       return state.response.toWidget(
      //         onCompleted: (context, data) => const SizedBox(),
      //         onRetry: () => cubit.watch(showLoading: true),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
