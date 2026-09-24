import 'package:assignment_test_app/core/constants/global.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/core/widgets/cached_network_image_widget.dart';
import 'package:assignment_test_app/data/models/watch_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.result, required this.context});

  final Result result;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: AspectRatio(
        aspectRatio: 670 / 360,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedNetworkImage(
              imageUrl: GlobalConstants.imageGetURL(result.posterPath),
            ),

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
                    colors: [
                      Colors.black.withValues(alpha: 0.85),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: Text(
                result.originalTitle!,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
