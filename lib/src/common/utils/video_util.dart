import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/video_config/video_optimizer_config.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:video_optimizer/index.dart';

class VideoUtil {
  static final OptimizerController _optimizerController = OptimizerController(videoOptimizer: FfmpegOptimize());
  static bool _isInitialized = false;

  static VideoConfig _getVideoOptimizerConfig({
    ValueChanged<int>? onProgressStart,
    final ValueChanged<int>? onProgress,
    final VoidCallback? onProgressEnd,
    final ValueChanged<dynamic>? onError,
    final String? configString,
  }) {
    var configInString = configString ?? RemoteConfigHelper().getString(AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG);
    VideoOptimizerConfig config = VideoOptimizerConfig.fromJson(jsonDecode(configInString));
    return VideoConfig(
      crf: config.crf,
      videoCodec: VideoCodec.fromString(config.videoCodec),
      videoPreset: VideoPreset.fromString(config.videoPreset),
      onProgressEnd: onProgressEnd,
      onProgress: onProgress,
      onError: onError,
      onProgressStart: onProgressStart,
      timeConfig: Validator.isTrue(config.addTimeStamp)
          ? VideoTimeConfig(
              fontSize: config.fontSize ?? 24,
              fontColor: config.fontColor ?? 'white',
              borderColor: config.borderColor ?? 'black',
            )
          : null,
    );
  }

  static Future<String?> compressVideo(String filePath, int videoLength,
      {final ValueChanged<int>? onProgress, String? configString}) async {
    if (!_isInitialized) {
      await _optimizerController.init();
      _isInitialized = true;
    }
    var dir = await tempDirectory;
    var outputPath = "${dir.path}/video_${now()}.mp4";
    String? errorWhileCompression;
    VideoConfig config = _getVideoOptimizerConfig(
        onProgress: onProgress,
        configString: configString,
        onError: (value) {
          errorWhileCompression = value.toString();
        });

    await _optimizerController.optimizeVideo(
        inputPath: filePath, outputPath: outputPath, videoTime: videoLength * 1000, config: config);

    if (errorWhileCompression != null) {
      return Future.error(errorWhileCompression!);
    } else {
      return Future.value(outputPath);
    }
  }
}
