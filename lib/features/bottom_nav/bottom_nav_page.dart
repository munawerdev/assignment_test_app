import 'package:assignment_test_app/config/theme/app_text_styles.dart';
import 'package:assignment_test_app/core/utils/extensions.dart';
import 'package:assignment_test_app/features/bottom_nav/bottom_nav_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import 'bottom_nav_cubit.dart';

class BottomNavPage extends StatefulWidget {
  final BottomNavCubit cubit;

  const BottomNavPage({super.key, required this.cubit});

  @override
  State<BottomNavPage> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavPage> {
  BottomNavCubit get cubit => widget.cubit;

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final state = cubit.state;
        if (state.selectedIndex > 0) {
          cubit.setSelectedIndex(0);
          return;
        }

        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => const ExitAppDialog(
            text: 'Are you sure you want to exit the app?',
            label: 'Exit App',
            onPressed: SystemNavigator.pop,
          ),
        );

        if (shouldExit == true) {
          await SystemNavigator.pop();
        }
      },
      child: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          state as BottomNavState;
          return Scaffold(
            bottomNavigationBar: Container(
              height: 75.h,
              padding: EdgeInsets.symmetric(horizontal: 49.w),
              decoration: BoxDecoration(
                color: const Color(0xff2E2739),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27.r),
                  topRight: Radius.circular(27.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: List.generate(cubit.pages.length, (index) {
                  final isSelected = state.selectedIndex == index;

                  return GestureDetector(
                    onTap: () => cubit.setSelectedIndex(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Image.asset(
                          cubit.tabIcons[index],
                          height: 18.h,
                          width: 18.w,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xff827D88),
                        ),
                        7.verticalSpace,

                        Text(
                          cubit.tabLabels[index],
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontFamily: AppTextStyles.roboto,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff827D88),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            body: cubit.pages.elementAt(state.selectedIndex),
          );
        },
      ),
    );
  }
}

class ExitAppDialog extends StatelessWidget {
  final String text;
  final String label;
  final VoidCallback onPressed;
  const ExitAppDialog({
    super.key,
    required this.text,
    required this.label,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(text),
    actions: [TextButton(onPressed: onPressed, child: Text(label))],
  );
}
