import 'package:assignment_test_app/config/theme/app_text_styles.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.labels,
    required this.icons,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final List<String> icons;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    final barHeight = landscape ? 58.0 : 75.h;
    final horizontalPadding = landscape ? 24.0 : 49.w;
    final iconSize = landscape ? 16.0 : 18.h;

    return Container(
      height: barHeight,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: const Color(0xff2E2739),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27.r),
          topRight: Radius.circular(27.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(labels.length, (index) {
          final selected = selectedIndex == index;
          final color = selected ? Colors.white : const Color(0xff827D88);
          return Semantics(
            button: true,
            selected: selected,
            label: labels[index],
            child: InkWell(
              onTap: () => onSelected(index),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: landscape ? 3 : 6.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icons[index],
                      height: iconSize,
                      width: iconSize,
                      color: color,
                    ),
                    SizedBox(height: landscape ? 3 : 5),
                    Text(
                      labels[index],
                      style: context.textTheme.bodySmall?.copyWith(
                        // Keep labels legible and stable when the short screen
                        // dimension changes in landscape.
                        fontSize: 10,
                        fontFamily: AppTextStyles.roboto,
                        color: color,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
