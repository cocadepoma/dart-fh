import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final VideoPost video;

  const FullScreenPlayer({
    super.key,
    required this.video
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
        controller = VideoPlayerController.network(widget.video.videoUrl)
          ..setVolume(0.3)
          ..setLooping(true)
          ..play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 3));
        }

        return GestureDetector(
          onTap: () {
            if(controller.value.isPlaying) {
              controller.pause();
              return;
            }
            controller.play();
          },
            child: Transform.scale(
              scaleX: 1.1,
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(controller),
                          
                    const VideoBackground(stops: [0.6, 1.0]),
                    
                    Positioned(
                      bottom: 40,
                      left: 30,
                      child: _VideoCaption(caption: widget.video.caption)
                    ),
                    Positioned(
                      bottom: 27,
                      right: 30,
                      child: VideoButtons(video: widget.video)
                    )
                  ],
                ),
              ),
            ),
        );
      },

    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({
    required this.caption
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.8,
      child: Text(caption, maxLines: 2, style: const TextStyle(fontSize: 12)),
    );
  }
}


