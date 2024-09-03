import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';

extension RetryFuture<T> on Future<T> {
  Future<T> retry(int maxRetries, {Duration? duration}) {
    var completer = Completer<T>();
    var retries = 0;
    void retry() {
      then((value) {
        completer.complete(value);
      }).catchError((error) {
        if (retries < maxRetries) {
          retries++;
          Future.delayed(duration ?? Duration.zero, retry);
        } else {
          completer.completeError(error);
        }
      });
    }

    retry();
    return completer.future;
  }
}

mixin VideoCompressionMixin {
  final StreamController<int> _fileCompressProgressStream = StreamController.broadcast();

  Future<String> compressVideo(String filePath, int videoTimeInSec) {
    var completer = Completer<String>();
    void progress(int value) {
      _fileCompressProgressStream.add(value);
    }

    _withRetry(() => _compressVideo(filePath, videoTimeInSec, progress), 3).then((outputPath) {
      if (outputPath != null) {
        completer.complete(outputPath);
      } else {
        completer.completeError('Error while compressing video');
      }
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

  Future<String?> _withRetry(Future<dynamic> Function() callableFunction, int maxRetry,
      {Duration duration = const Duration(seconds: 2)}) async {
    for (int attempt = 0; attempt < maxRetry; attempt++) {
      try {
        String? outputPath = await callableFunction();
        return Future.value(outputPath);
      } catch (error) {
        if (attempt >= (maxRetry -1)) {
          return Future.error(error.toString());
        }
        await Future.delayed(duration);
        continue;
      }
    }
    return Future.error("error");
  }

  Future<String?> _compressVideo(String filePath, int videoTimeInSec, ValueChanged<int> progress) {
    return VideoUtil.compressVideo(filePath, videoTimeInSec, onProgress: progress);
  }
}
