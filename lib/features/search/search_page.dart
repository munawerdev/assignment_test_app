import 'package:material_ui/material_ui.dart';

import 'search_cubit.dart';

class SearchPage extends StatefulWidget {
  final SearchCubit cubit;

  const SearchPage({super.key, required this.cubit});

  @override
  State<SearchPage> createState() => _SearchState();
}

class _SearchState extends State<SearchPage> {
  SearchCubit get cubit => widget.cubit;

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
    return const Scaffold();
  }
}
