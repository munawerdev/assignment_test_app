import 'package:assignment_test_app/core/constants/status_switcher.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/features/watch/watch_state.dart';
import 'package:assignment_test_app/features/watch/widget/movie_card.dart';
import 'package:assignment_test_app/features/watch/widget/movie_card_shimmer.dart';
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
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: cubit.watch,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
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
                  fontSize: landscape ? 16 : null,
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  tooltip: 'Search',
                  onPressed: () => cubit.goCategory(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.search_rounded,
                    color: const Color(0xff202C43),
                    size: landscape ? 20 : 24.r,
                  ),
                ),
                16.horizontalSpace,
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.h),
                child: Container(height: 1.h, color: const Color(0xffE8E7EC)),
              ),
            ),
            SliverToBoxAdapter(child: 30.verticalSpace),
            SliverToBoxAdapter(
              child: BlocBuilder(
                bloc: cubit,
                builder: (context, state) {
                  state as WatchState;
                  return state.response.toWidget(
                    onRetry: () => cubit.watch(),
                    onLoading: (context) => MovieCardShimmer(landscape: landscape),
                    onCompleted: (context, data) {
                      final results = data.results ?? [];
                      if (landscape) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: results.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14.w,
                            mainAxisSpacing: 14.h,
                            childAspectRatio: 1.86,
                          ),
                          itemBuilder: (context, index) {
                            final result = results[index];
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => cubit.goMovieDetailPage(result: result),
                              child: MovieCard(
                                result: result,
                                context: context,
                                landscape: true,
                              ),
                            );
                          },
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => cubit.goMovieDetailPage(result: result),
                            child: MovieCard(result: result, context: context),
                          );
                        },
                        separatorBuilder: (context, index) => 20.verticalSpace,
                      );
                    },
                  );
                },
              ),
            ),

            SliverToBoxAdapter(child: 30.verticalSpace),
          ],
        ),
      ),
    );
  }
}
