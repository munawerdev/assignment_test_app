import 'package:assignment_test_app/features/bottom_nav/bottom_nav_state.dart';
import 'package:assignment_test_app/features/bottom_nav/widget/app_bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            bottomNavigationBar: AppBottomNavigationBar(
              labels: cubit.tabLabels,
              icons: cubit.tabIcons,
              selectedIndex: state.selectedIndex,
              onSelected: cubit.setSelectedIndex,
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
