import 'package:assignment_test_app/core/constants/status_switcher.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/data/models/watch_model.dart';
import 'package:assignment_test_app/features/watch/watch_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

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
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            snap: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            toolbarHeight: 64.h,
            titleSpacing: 20.w,
            title: Text(
              'Watch',
              style: context.textTheme.titleMedium?.copyWith(
                color: const Color(0xff202C43),
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: 'Search',
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                icon: Icon(
                  Icons.search_rounded,
                  color: const Color(0xff202C43),
                  size: 24.r,
                ),
              ),
              16.horizontalSpace,
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Container(height: 1.h, color: const Color(0xffE8E7EC)),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          RefreshIndicator.adaptive(
            onRefresh: cubit.watch,
            child: BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                state as WatchState;
                return state.response.toWidget(
                  onRetry: () => cubit.watch(showLoading: true),
                  onCompleted: (context, data) => SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList.separated(
                      itemCount: data.results.length,
                      itemBuilder: (context, index) =>
                          _MovieCard(result: data.results[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(10.r),
    child: const AspectRatio(aspectRatio: 670 / 360, child: SizedBox()),
  );
}
