import 'package:assignment_test_app/core/constants/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key, this.landscape = false});
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[800]!;

    if (landscape) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: 1.86,
          ),
          itemBuilder: (context, index) => _ShimmerTile(baseColor: baseColor),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: _ShimmerTile(baseColor: baseColor),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile({required this.baseColor});
  final Color baseColor;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(10.r),
    child: AspectRatio(
      aspectRatio: 670 / 360,
      child: AppShimmer.shimmer(
        context,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: baseColor),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 120.h,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [baseColor.withValues(alpha: 0.9), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                height: 24.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
