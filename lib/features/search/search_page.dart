import 'dart:async';

import 'package:assignment_test_app/config/response/status.dart';
import 'package:assignment_test_app/core/constants/global.dart';
import 'package:assignment_test_app/core/constants/status_switcher.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/core/widgets/app_text_form_field.dart';
import 'package:assignment_test_app/core/widgets/cached_network_image_widget.dart';
import 'package:assignment_test_app/data/models/watch_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import 'search_cubit.dart';
import 'search_state.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;

  const SearchPage({super.key, required this.cubit});

  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  SearchCubit get cubit => widget.cubit;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.loadPopularMovies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    cubit.close();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _submitted = false);
    _debounce?.cancel();
    final query = value.trim();
    if (query.length < 2) {
      cubit.showPopularMovies();
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: 350),
      () => cubit.search(value),
    );
  }

  void _submit(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty) return;
    setState(() => _submitted = true);
    _focusNode.unfocus();
    if (cubit.state.query != value.trim() ||
        cubit.state.response.status == Status.INITIAL) {
      cubit.search(value);
    }
  }

  void _editSearch() {
    setState(() => _submitted = false);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final landscape = context.isLandscape;
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        bloc: cubit,
        builder: (context, state) => CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            _buildHeader(context, landscape),
            if (!_submitted) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    landscape ? 28 : 20.w,
                    landscape ? 20 : 28.h,
                    landscape ? 28 : 20.w,
                    landscape ? 6 : 8.h,
                  ),
                  child: Text(
                    'Top Results',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: const Color(0xff202C43),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: landscape ? 28 : 20.w,
                  ),
                  child: const Divider(height: 1, color: Color(0xffD9D9DE)),
                ),
              ),
            ],
            ..._buildResultSlivers(context, state, landscape),
          ],
        ),
      ),
      bottomNavigationBar: _submitted && !_focusNode.hasFocus
          ? _SearchBottomNavigation(onTap: cubit.openTab, landscape: landscape)
          : null,
    );
  }

  SliverAppBar _buildHeader(BuildContext context, bool landscape) {
    if (_submitted) {
      return SliverAppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: landscape ? 72 : 98.h,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: _editSearch,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: const Color(0xff202C43),
                  size: landscape ? 20 : 24.r,
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  bloc: cubit,
                  builder: (context, state) {
                    final count = state.response.status == Status.COMPLETED
                        ? state.response.data.totalResults ??
                              state.response.data.results?.length ??
                              0
                        : 0;
                    return Text(
                      '$count Results Found',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: const Color(0xff202C43),
                        fontSize: landscape ? 16 : null,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverAppBar(
      floating: true,
      stretch: true,
      snap: true,
      automaticallyImplyLeading: false,
      toolbarHeight: landscape ? 72 : 98.h,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: const Color(0xff202C43),
                size: landscape ? 20 : 24.r,
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: AppTextFormField(
                controller: _controller,
                focusNode: _focusNode,
                hintText: 'TV shows, movies and more',
                textInputAction: TextInputAction.search,
                onChanged: _onChanged,
                onFieldSubmitted: _submit,
                config: landscape
                    ? AppTextFieldConfig(
                        textStyle: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                        ),
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                        ),
                      )
                    : null,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: const Color(0xff202C43),
                  size: landscape ? 20 : 24.r,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _onChanged('');
                    _focusNode.requestFocus();
                  },
                  child: Icon(
                    Icons.close,
                    color: const Color(0xff202C43),
                    size: landscape ? 18 : 24.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(height: 1.h, color: const Color(0xffEFEFEF)),
      ),
    );
  }

  List<Widget> _buildResultSlivers(
    BuildContext context,
    SearchState state,
    bool landscape,
  ) {
    if (state.response.status == Status.INITIAL) {
      if (_controller.text.trim().isNotEmpty) {
        return [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Enter at least 2 characters',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xff92949D),
                ),
              ),
            ),
          ),
        ];
      }
      return [
        const SliverFillRemaining(hasScrollBody: false, child: SizedBox()),
      ];
    }

    if (state.response.status == Status.LOADING) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CupertinoActivityIndicator()),
        ),
      ];
    }

    if (state.response.status == Status.ERROR) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: state.response.toWidget(
            onRetry: () => cubit.search(state.query),
            onCompleted: (_, _) => const SizedBox.shrink(),
          ),
        ),
      ];
    }

    final results = state.response.data.results ?? const <Result>[];
    final items = state.query.isEmpty ? results.take(10).toList() : results;
    if (items.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              'No movies found',
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xff92949D),
              ),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: EdgeInsets.fromLTRB(
          landscape ? 28 : 20.w,
          landscape ? (_submitted ? 20 : 14) : (_submitted ? 30.h : 20.h),
          landscape ? 28 : 20.w,
          landscape ? 18 : 24.h,
        ),
        sliver: SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemBuilder: (context, index) => _SearchResultTile(
            result: items[index],
            landscape: landscape,
            onTap: () => cubit.openMovie(items[index]),
            onOptions: () => _showMovieActions(
              context,
              items[index].title ?? items[index].originalTitle ?? 'Movie',
              () => cubit.openMovie(items[index]),
            ),
          ),
        ),
      ),
    ];
  }

  void _showMovieActions(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(title),
        message: const Text('Choose an action for this movie.'),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              onTap();
            },
            child: const Text('View Details'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({
    required this.result,
    required this.onTap,
    required this.onOptions,
    required this.landscape,
  });

  final Result result;
  final VoidCallback onTap;
  final VoidCallback onOptions;
  final bool landscape;

  static const _genres = <int, String>{
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  @override
  Widget build(BuildContext context) {
    final title = result.title ?? result.originalTitle ?? 'Untitled';
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double imageWidth = landscape
        ? (screenWidth * 0.27).clamp(170.0, 230.0).toDouble()
        : 130.w;
    final imageHeight = landscape ? imageWidth / 1.3 : 100.h;
    final genre = result.genreIds
        ?.map((id) => _genres[id])
        .whereType<String>()
        .take(2)
        .join(' • ');
    return SizedBox(
      height: imageHeight,
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: AppCachedNetworkImage(
                  imageUrl: GlobalConstants.imageGetURL(result.posterPath),
                ),
              ),
            ),
          ),
          SizedBox(width: landscape ? 22 : 20.w),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: const Color(0xff202C43),
                      fontSize: landscape ? 16 : 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (genre != null && genre.isNotEmpty) ...[
                    SizedBox(height: 5.h),
                    Text(
                      genre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xffD4D5DB),
                        fontSize: landscape ? 13 : null,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            onPressed: onOptions,
            child: const Icon(
              CupertinoIcons.ellipsis,
              color: Color(0xff61C3F2),
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBottomNavigation extends StatelessWidget {
  const _SearchBottomNavigation({required this.onTap, required this.landscape});
  final ValueChanged<int> onTap;
  final bool landscape;

  static const _labels = ['Dashboard', 'Watch', 'Media Library', 'More'];
  static const _icons = [
    Icons.apps_rounded,
    Icons.smart_display_rounded,
    Icons.video_library_rounded,
    Icons.toc_rounded,
  ];

  @override
  Widget build(BuildContext context) => Container(
    height: landscape ? 64 : 75.h,
    padding: EdgeInsets.symmetric(horizontal: landscape ? 40 : 28.w),
    decoration: BoxDecoration(
      color: const Color(0xff2E2739),
      borderRadius: BorderRadius.vertical(top: Radius.circular(27.r)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_labels.length, (index) {
        final selected = index == 1;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onTap(index),
          child: SizedBox(
            width: 68.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _icons[index],
                  size: landscape ? 18 : 18.r,
                  color: selected ? Colors.white : const Color(0xff827D88),
                ),
                SizedBox(height: 5.h),
                Text(
                  _labels[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: landscape ? 10 : 10.sp,
                    color: selected ? Colors.white : const Color(0xff827D88),
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}
