import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';
import 'package:video_player/video_player.dart';

mixin VideoCompressionMixin {
  final StreamController<int> _fileCompressProgressStream = StreamController.broadcast();

  Future<String> compressVideo(String filePath) {
    var completer = Completer<String>();
    VideoPlayerController videoPlayerController = VideoPlayerController.file(File(filePath));
    videoPlayerController.initialize().then((_) {
      VideoUtil.compressVideo(filePath, videoPlayerController.value.duration.inSeconds, onProgress: (value) {
        _fileCompressProgressStream.add(value);
      }).then((String? outputPath) {
        if (outputPath != null) {
          completer.complete(outputPath);
        } else {
          completer.completeError('Error while compressing video');
        }
      }, onError: (error) {
        completer.completeError(error.toString());
      });
    }, onError: (error) {
      completer.completeError(error.toString());
    });
    return completer.future;
  }

  Widget buildProgressContainer(ThemeData theme) {
    return StreamBuilder(
      stream: _fileCompressProgressStream.stream,
      builder: (_, snapshot) {
        var progress = snapshot.data;
        if ((progress ?? 0) > 100) {
          progress = 100;
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CshCard(
                padding: const EdgeInsets.all(Dimens.space_24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CshTextNew.h3("Optimizing Video - ${progress ?? 0}%"),
                    const SizedBox(height: Dimens.space_16),
                    LinearProgressIndicator(
                      value: (progress ?? 0) / 100,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                      backgroundColor: theme.primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(Dimens.space_6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
