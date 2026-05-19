import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'l10n.dart';

class VideoPreview extends StatefulWidget {
  final String filePath;

  const VideoPreview({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _initVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.filePath));
    await _controller.initialize();
    await _controller.setLooping(false);
    // await _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    L10n l10n = L10n(context);
    return Scaffold(
      appBar: CshHeader(
        l10n.packagingVideo,
        showBackBtn: true,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: cshGestureDetector(
              child: Text(
                l10n.cancel,
                style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: !_controller.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(_controller),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            top: 0,
                            child: Container(
                              color: _controller.value.isPlaying?Colors.black.withOpacity(0.0):Colors.black.withOpacity(0.6),
                              child: CshIcon(
                                _controller.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline,
                                iconColor: _controller.value.isPlaying?Colors.transparent:Colors.white,
                                iconSize: MobileIconSize.xxLarge,
                                onClick: () {
                                  setState(() {
                                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(minHeight: 68),
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
                  child: CshBigButton(
                    text: l10n.uploadVideo,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
    );
  }
}
