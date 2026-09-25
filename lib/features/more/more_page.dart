import 'package:assignment_test_app/core/widgets/app_empty_state.dart';
import 'package:material_ui/material_ui.dart';

import 'more_cubit.dart';

class MorePage extends StatefulWidget {
  final MoreCubit cubit;

  const MorePage({super.key, required this.cubit});

  @override
  State<MorePage> createState() => _MoreState();
}

class _MoreState extends State<MorePage> {
  MoreCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppEmptyState(
        icon: Icons.more_horiz_rounded,
        title: 'More features coming soon',
        message: 'Additional settings and features will be available here.',
      ),
    );
  }
}
