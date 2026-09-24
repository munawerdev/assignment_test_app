import 'package:material_ui/material_ui.dart';

import 'dashboard_cubit.dart';

class DashboardPage extends StatefulWidget {
  final DashboardCubit cubit;

  const DashboardPage({super.key, required this.cubit});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  DashboardCubit get cubit => widget.cubit;

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
    return const Scaffold(body: Center(child: Text('Daahboard')));
  }
}
