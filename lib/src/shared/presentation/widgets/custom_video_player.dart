import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_gradient_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    super.key,
    required this.assetPath,
    required this.caption,
    required this.username,
  });
  final String assetPath;
  final String? caption;
  final String? username;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset(widget.assetPath);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoPlayerController.value.isInitialized) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          if (_videoPlayerController.value.isPlaying) {
            setState(() {
              _videoPlayerController.pause();
            });
          } else {
            _videoPlayerController.play();
          }
        },
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              const CustomGradientOverlay(),
              widget.caption == null && widget.username == null
                  ? const SizedBox()
                  : _VideoCaption(
                      username: widget.username!,
                      caption: widget.caption!,
                    )
            ],
          ),
        ),
      );
    }
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    required this.username,
    required this.caption,
  });

  final String username;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              username,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
