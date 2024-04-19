
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'widgets.dart';

Logger logger = Logger();

class VideoPost extends StatefulWidget {
  const VideoPost({super.key,
    required this.assetPath,
    this.caption,
    this.username,
    required this.isPlaying});
    final String assetPath;
  final String? caption;
  final String? username;
  final bool isPlaying;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  File? preview;
@override
  void initState() {
    try {
    _generateThumbail().then((value) => setState(() {
      if (value != null) {
      preview = value;
      }

    }));
    } catch(e) {
logger.e(e);
    }

    super.initState();
  }

  Future<File?> _generateThumbail() async {
final byteData = await rootBundle.load(widget.assetPath);
Directory tempDir = await getTemporaryDirectory();

File tempVideo = File("${tempDir.path}/${widget.assetPath}")
  ..createSync(recursive: true)
  ..writeAsBytesSync(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

final fileName = await VideoThumbnail.thumbnailFile(
  video: tempVideo.path,
  thumbnailPath: (await getTemporaryDirectory()).path,
  imageFormat: ImageFormat.PNG,  
  quality: 100,
);
logger.i(fileName);
return fileName != null ? File(fileName) : null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPlaying ? _CustomVideoPlayer(assetPath: widget.assetPath, caption: widget.caption, username: widget.username) : _VideoPreview(preview: preview, caption: widget.caption, username: widget.username);
  }
}

class _CustomVideoPlayer extends StatefulWidget {
  const _CustomVideoPlayer({
    required this.assetPath,
    this.caption,
    this.username,
  });
  final String assetPath;
  final String? caption;
  final String? username;

  @override
  State<_CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<_CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

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
                    ),
              
            ],
          ),
        ),
      );
    }
  }
}

class _VideoPreview extends StatelessWidget {
  const _VideoPreview({required this.preview, required this.caption, required this.username});
  final String? caption;
  final String? username;
  final File? preview;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [preview != null ? Image.file(preview!) : const SizedBox(),const Center(child:Icon(Icons.play_arrow_rounded, size: 50, color: Color.fromARGB(162, 255, 255, 255),)),const CustomGradientOverlay(),
              caption == null && username == null
                  ? const SizedBox()
                  : _VideoCaption(
                      username: username!,
                      caption: caption!,
                    ), ]);
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