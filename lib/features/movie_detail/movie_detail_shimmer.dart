import 'package:assignment_test_app/core/constants/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class MovieDetailShimmer extends StatelessWidget {
  const MovieDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(
      parent: BouncingScrollPhysics(),
    ),
    slivers: [
      SliverToBoxAdapter(child: _HeroShimmer()),
      SliverToBoxAdapter(child: _DetailsShimmer()),
    ],
  );
}

class _HeroShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const heroColor = Color(0xff5A5A5A);

    return SizedBox(
      height: 466.h,
      child: AppShimmer.shimmer(
        context,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: heroColor),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: .08),
                    Colors.black.withValues(alpha: .52),
                  ],
                  stops: const [.35, 1],
                ),
              ),
            ),
            Positioned(
              top: 59.h,
              left: 16.w,
              child: Row(
                children: [
                  _Block(width: 24.r, height: 24.r, radius: 12.r),
                  SizedBox(width: 15.w),
                  _Block(width: 58.w, height: 20.h),
                ],
              ),
            ),
            Positioned(
              left: 66.w,
              right: 66.w,
              bottom: 34.h,
              child: Column(
                children: [
                  _Block(width: 190.w, height: 20.h),
                  SizedBox(height: 6.h),
                  _Block(width: 145.w, height: 18.h),
                  SizedBox(height: 15.h),
                  _Block(width: double.infinity, height: 46.h, radius: 23.r),
                  SizedBox(height: 10.h),
                  _Block(width: double.infinity, height: 46.h, radius: 23.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(40.w, 27.h, 40.w, 57.h),
    child: AppShimmer.shimmer(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Block(width: 72.w, height: 20.h),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 5.w,
            runSpacing: 5.h,
            children: [
              _Block(width: 66.w, height: 26.h, radius: 16.r),
              _Block(width: 82.w, height: 26.h, radius: 16.r),
              _Block(width: 58.w, height: 26.h, radius: 16.r),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 22.h, bottom: 15.h),
            child: Container(height: 1.h, color: const Color(0xffD8D8D8)),
          ),
          _Block(width: 94.w, height: 20.h),
          SizedBox(height: 14.h),
          _Block(width: double.infinity, height: 12.h),
          SizedBox(height: 7.h),
          _Block(width: double.infinity, height: 12.h),
          SizedBox(height: 7.h),
          _Block(width: 210.w, height: 12.h),
        ],
      ),
    ),
  );
}

class _Block extends StatelessWidget {
  const _Block({required this.width, required this.height, this.radius = 4});

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: const Color(0xffB8B8B8),
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
