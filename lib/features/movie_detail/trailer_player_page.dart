import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerPage extends StatefulWidget {
  const TrailerPlayerPage({super.key, required this.videoId});

  final String videoId;

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _controller.dispose();
    // Return control to the app's supported orientations. Forcing portrait here
    // can be rejected by iOS while the landscape-only player controller closes.
    SystemChrome.setPreferredOrientations(const []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _close() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onEnded: (_) => _close(),
          ),
        ),
        Positioned(
          top: 8,
          right: 12,
          child: SafeArea(
            child: TextButton(
              onPressed: _close,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Done'),
            ),
          ),
        ),
      ],
    ),
  );
}
