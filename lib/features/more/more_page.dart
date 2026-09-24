import 'package:flutter/material.dart';

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
    return const Scaffold(body: Center(child: Text('More')));
  }
}
