import 'package:assignment_test_app/core/widgets/app_empty_state.dart';
import 'package:material_ui/material_ui.dart';

import 'media_library_cubit.dart';

class MediaLibraryPage extends StatefulWidget {
  final MediaLibraryCubit cubit;

  const MediaLibraryPage({super.key, required this.cubit});

  @override
  State<MediaLibraryPage> createState() => _MediaLibraryState();
}

class _MediaLibraryState extends State<MediaLibraryPage> {
  MediaLibraryCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppEmptyState(
        icon: Icons.video_library_outlined,
        title: 'Your library is empty',
        message: 'Movies you save will appear here.',
      ),
    );
  }
}
