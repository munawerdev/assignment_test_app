import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/core/widgets/app_text_form_field.dart';
import 'package:assignment_test_app/core/widgets/cached_network_image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import 'category_cubit.dart';

class CategoryPage extends StatefulWidget {
  final CategoryCubit cubit;

  const CategoryPage({super.key, required this.cubit});

  @override
  State<CategoryPage> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryPage> {
  CategoryCubit get cubit => widget.cubit;

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
  Widget build(BuildContext context) {
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    const categories = <_CategoryTileData>[
      _CategoryTileData('Comedies', 'https://picsum.photos/id/366/780/440'),
      _CategoryTileData(
        'Crime',
        'https://image.tmdb.org/t/p/w780/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg',
      ),
      _CategoryTileData(
        'Family',
        'https://image.tmdb.org/t/p/w780/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg',
      ),
      _CategoryTileData(
        'Documentaries',
        'https://picsum.photos/id/1015/780/440',
      ),
      _CategoryTileData(
        'Dramas',
        'https://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
      ),
      _CategoryTileData('Fantasy', 'https://picsum.photos/id/28/780/440'),
      _CategoryTileData('Holidays', 'https://picsum.photos/id/1080/780/440'),
      _CategoryTileData('Horror', 'https://picsum.photos/id/110/780/440'),
      _CategoryTileData('Sci-Fi', 'https://picsum.photos/id/1043/780/440'),
      _CategoryTileData('Thriller', 'https://picsum.photos/id/1074/780/440'),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            snap: true,
            automaticallyImplyLeading: false,
            toolbarHeight: 98.h,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
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
                      hintText: 'TV shows, movies and more',
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
                      suffixIcon: Icon(
                        Icons.close,
                        color: const Color(0xff202C43),
                        size: landscape ? 18 : 24.r,
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
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 24.h),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: landscape ? 4 : 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: landscape ? 1.7 : 1.58,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) =>
                  _CategoryTile(data: categories[index], compact: landscape),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTileData {
  final String title;
  final String imageUrl;
  const _CategoryTileData(this.title, this.imageUrl);
}

class _CategoryTile extends StatelessWidget {
  final _CategoryTileData data;
  final bool compact;
  const _CategoryTile({required this.data, this.compact = false});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(11.r),
    child: Stack(
      fit: StackFit.expand,
      children: [
        AppCachedNetworkImage(imageUrl: data.imageUrl),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff000000).withValues(alpha: .3),
                const Color(0xff000000),
              ],
              stops: [0.30, 1],
            ),
          ),
        ),
        Positioned(
          left: 10.w,
          bottom: 20.h,
          child: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: compact ? 14 : null,
            ),
          ),
        ),
      ],
    ),
  );
}
