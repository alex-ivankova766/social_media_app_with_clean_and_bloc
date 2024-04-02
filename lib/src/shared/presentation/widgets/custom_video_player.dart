import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_gradient_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    super.key,
    required this.assetPath,
    this.caption,
    this.username,
  });
  final String assetPath;
  final String? caption;
  final String? username;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool isPlayingNow = false;

  @override
  void initState() {
    if (widget.assetPath.startsWith('assets/')) {
      _videoPlayerController = VideoPlayerController.asset(widget.assetPath);
    } else {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.assetPath));
    }
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.setLooping(true);
    // _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  _play() {
    if (_videoPlayerController.value.isPlaying) {
      setState(() {
        _videoPlayerController.pause();
        isPlayingNow = false;
      });
    } else {
      setState(() {
        _videoPlayerController.play();
        isPlayingNow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoPlayerController.value.isInitialized) {
      return const SizedBox();
    } else {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => _play(),
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
          ),
          (!isPlayingNow)
              ? Center(
                  child: SizedBox(
                    child: IconButton(
                      iconSize: 100,
                      icon: const Icon(Icons.play_arrow_rounded),
                      onPressed: () => _play(),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
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
