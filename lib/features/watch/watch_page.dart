import 'package:assignment_test_app/core/constants/status_switcher.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/core/widgets/paginated_list_view.dart';
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
            SliverToBoxAdapter(child: 30.verticalSpace),
            SliverToBoxAdapter(
              child: BlocBuilder(
                bloc: cubit,
                builder: (context, state) {
                  state as WatchState;
                  return state.response.toWidget(
                    onRetry: () => cubit.watch,
                    onLoading: (context) => const MovieCardShimmer(),
                    onCompleted: (context, data) =>
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   itemCount: data.results?.length ?? 0,
                        //   itemBuilder: (context, index) => MovieCard(
                        //     result: data.results![index],
                        //     context: context,
                        //   ),
                        //   separatorBuilder: (context, index) => 20.verticalSpace,
                        // ),
                        PaginatedListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          items: data.results!,
                          onRefresh:  cubit.watch,
                          itemBuilder: (context, result, index) =>
                              MovieCard(result: result, context: context),
                          isLoadingMore: state.isLoadingMore,
                          onLoadMore:  cubit.loadMore,
                        ),
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
