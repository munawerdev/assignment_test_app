import 'package:assignment_test_app/core/constants/global.dart';
import 'package:assignment_test_app/core/constants/status_switcher.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/core/widgets/app_button.dart';
import 'package:assignment_test_app/core/widgets/cached_network_image_widget.dart';
import 'package:assignment_test_app/data/models/movie_detail_model.dart';
import 'package:assignment_test_app/features/movie_detail/movie_detail_shimmer.dart';
import 'package:assignment_test_app/features/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import 'movie_detail_cubit.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.cubit});
  final MovieDetailCubit cubit;

  @override
  State<MovieDetailPage> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetailPage> {
  MovieDetailCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        state as MovieDetailState;
        return state.response.toWidget(
          onLoading: (context) => const MovieDetailShimmer(),
          onCompleted: (_, movie) => RefreshIndicator.adaptive(
            onRefresh: cubit.movieDetail,
            child: _MovieDetailContent(
              movie: movie,
              onWatchTrailer: cubit.watchTrailer,
            ),
          ),
          onRetry: cubit.movieDetail,
        );
      },
    ),
  );
}

class _MovieDetailContent extends StatelessWidget {
  const _MovieDetailContent({
    required this.movie,
    required this.onWatchTrailer,
  });
  final MovieDetailModel movie;
  final VoidCallback onWatchTrailer;

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    if (landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _Hero(
              movie: movie,
              onWatchTrailer: onWatchTrailer,
              landscape: true,
            ),
          ),
          Expanded(child: _Details(movie: movie, scrollable: true, landscape: true)),
        ],
      );
    }
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(child: _Hero(movie: movie, onWatchTrailer: onWatchTrailer)),
        SliverToBoxAdapter(child: _Details(movie: movie)),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    required this.movie,
    this.scrollable = false,
    this.landscape = false,
  });
  final MovieDetailModel movie;
  final bool scrollable;
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    final details = Padding(
      padding: EdgeInsets.fromLTRB(24.w, 27.h, 24.w, 57.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: context.textTheme.titleMedium!.copyWith(
              color: const Color(0xff202C43),
              fontSize: landscape ? 16 : null,
            ),
          ),
          14.verticalSpace,
          Wrap(
            spacing: 5.w,
            runSpacing: 5.h,
            children: movie.genres
                .asMap()
                .entries
                .map(
                  (entry) => _GenreChip(
                    label: entry.value.name ?? '',
                    color: _genreColors[entry.key % _genreColors.length],
                    compact: landscape,
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 22.h, bottom: 15.h),
            child: Divider(color: const Color(0xffE8E7EC), height: 1.h),
          ),
          Text(
            'Overview',
            style: context.textTheme.titleMedium!.copyWith(
              color: const Color(0xff202C43),
              fontSize: landscape ? 16 : null,
            ),
          ),
          14.verticalSpace,
          Text(
            movie.overview?.trim().isNotEmpty == true
                ? movie.overview!
                : 'No overview is available for this movie.',
            style: context.textTheme.bodySmall?.copyWith(
              color: const Color(0xff8F8F8F),
              height: 1.6,
              fontSize: landscape ? 13 : null,
            ),
          ),
        ],
      ),
    );
    if (!scrollable) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: details,
      );
    }
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: details,
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.movie,
    required this.onWatchTrailer,
    this.landscape = false,
  });
  final MovieDetailModel movie;
  final VoidCallback onWatchTrailer;
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    final date = movie.releaseDate == null
        ? null
        : _formatDate(movie.releaseDate!);
    return SizedBox(
      height: landscape ? null : 466.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppCachedNetworkImage(
            imageUrl: GlobalConstants.imageGetURL(
              movie.backdropPath ?? movie.posterPath,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .12),
                  Colors.black.withValues(alpha: .72),
                ],
                stops: const [.35, 1],
              ),
            ),
          ),

          Positioned(
            top: 59,
            child: TextButton.icon(
              onPressed: () => Navigator.maybePop(context),

              icon: Padding(
                padding: EdgeInsets.only(right: 15.w),

                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24.r,
                ),
              ),

              label: Text(
                'Watch',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: landscape ? 16 : null,
                ),
              ),
            ),
          ),
          Positioned(
            left: landscape ? 16.w : 66.w,
            right: landscape ? 16.w : 66.w,
            bottom: landscape ? 18.h : 34.h,
            child: Column(
              children: [
                Text(
                  movie.title ?? movie.originalTitle ?? '',
                  textAlign: TextAlign.center,

                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: landscape ? 22 : null,
                  ),
                ),
                if (date != null) ...[
                  6.verticalSpace,
                  Text(
                    'In Theaters $date',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: landscape ? 16 : null,
                    ),
                  ),
                ],
                15.verticalSpace,
                if (landscape)
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Get Tickets',
                          onPressed: () {},
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: AppButton.outlined(
                          text: 'Watch Trailer',
                          onPressed: onWatchTrailer,
                          icon: const Icon(Icons.play_arrow_rounded, size: 20),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                    ],
                  )
                else ...[
                  AppButton(text: 'Get Tickets', onPressed: () {}),
                  10.verticalSpace,
                  AppButton.outlined(
                    text: 'Watch Trailer',
                    onPressed: onWatchTrailer,
                    icon: const Icon(Icons.play_arrow_rounded, size: 24),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({
    required this.label,
    required this.color,
    this.compact = false,
  });
  final String label;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Text(
      label,
      style: context.textTheme.labelMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: compact ? 12 : null,
      ),
    ),
  );
}

const _genreColors = [
  Color(0xff1BC9BA),
  Color(0xffDD6AA9),
  Color(0xff5549A5),
  Color(0xffD9A500),
];

String _formatDate(DateTime date) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}
