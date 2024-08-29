import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';

mixin VideoCompressionMixin {
  final StreamController<int> _fileCompressProgressStream = StreamController.broadcast();

  Future<String> compressVideo(String filePath, int videoTimeInSec) {
    var completer = Completer<String>();
    VideoUtil.compressVideo(filePath, videoTimeInSec, onProgress: (value) {
      _fileCompressProgressStream.add(value);
    }).then((String? outputPath) {
      if (outputPath != null) {
        completer.complete(outputPath);
      } else {
        completer.completeError('Error while compressing video');
      }
    }, onError: (error) {
      Logger.debug('mydebug-----VideoCompressionMixin.compressVideo', ['error', error]);
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
