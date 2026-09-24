import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '/core/constants/status_switcher.dart';
import 'search_cubit.dart';
import 'search_state.dart';

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
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: cubit.search,
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            state as SearchState;
            return state.response.toWidget(
              onCompleted: (context, data) => const SizedBox(),
              onRetry: () => cubit.search(showLoading: true),
            );
          },
        ),
      ),
    );
  }
}
