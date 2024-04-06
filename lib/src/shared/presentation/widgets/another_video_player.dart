import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';

Logger logger = Logger();

class AnotherVideoPlayer extends StatefulWidget {
  const AnotherVideoPlayer({
    super.key,
    required this.assetPath,
    this.caption,
    this.username,
  });
  final String assetPath;
  final String? caption;
  final String? username;

  @override
  State<AnotherVideoPlayer> createState() => _AnotherVideoPlayerState();
}

class _AnotherVideoPlayerState extends State<AnotherVideoPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    try {
flickManager = FlickManager(
  autoPlay: false,
  autoInitialize: true,
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse("https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4"), videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
    );
    } catch (error) {
      logger.e(error);
    }
    
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(
        
        flickManager: flickManager
      ),
    );
  }
}