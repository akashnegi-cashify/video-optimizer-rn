import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_video_service.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class D2CVideoProvider extends CshChangeNotifier {
  String? deviceBarcode;
  String? deviceName;
  String? deviceError;

  final StreamController<int> _fileUploadProgressStream = StreamController.broadcast();

  final StreamController<int> _fileCompressProgressStream = StreamController.broadcast();
  String? videoUrl;
  String? _compressedFilePath;

  D2CVideoProvider(this.deviceBarcode);

  StreamController<int> get fileUploadProgressStream => _fileUploadProgressStream;

  String? get compressedFilePath => _compressedFilePath;

  StreamController<int> get fileCompressProgressStream => _fileCompressProgressStream;

  static D2CVideoProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<D2CVideoProvider>(context, listen: listen);
  }

  String _getConfigInString() {
    return RemoteConfigHelper().getString(AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C);
  }

  Future<String> compressVideo(String path) async {
    var completer = Completer<String>();
    // File(path).logFileSize();
    VideoPlayerController videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    VideoUtil.compressVideo(path, videoPlayerController.value.duration.inSeconds, configString: _getConfigInString(),
        onProgress: (value) {
      _fileCompressProgressStream.add(value);
    }).then((String? outputPath) {
      if (outputPath != null) {
        // File(outputPath).logFileSize();
        _compressedFilePath = outputPath;
        completer.complete(outputPath);
      }
    }, onError: (error) {
      completer.completeError(error.toString());
    });
    return completer.future;
  }

  Future<void> uploadMedia(String filePath) {
    var completer = Completer<void>();
    var file = File(filePath);
    String fileName = path.basename(file.path);
    MediaUploadUtil()
        .uploadMediaWithType(
      mediaFile: file,
      fileName: fileName,
      contentType: MediaContentType.mp4,
      onProgress: (progress) {
        Logger.debug('mydebug-----D2CVideoProvider.uploadMedia', [progress]);
        _fileUploadProgressStream.add(progress);
      },
    )
        .then((value) {
      videoUrl = value;
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<void> updateData() {
    var completer = Completer<void>();
    D2CVideoService.saveVideo(deviceBarcode, videoUrl).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  Future<void> getDeviceDetails() {
    var completer = Completer<void>();
    D2CVideoService.getDeviceDetails(deviceBarcode).listen((event) {
      deviceName = event.modelName;
      completer.complete();
      notifyListeners();
    }, onError: (error) {
      deviceError = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(error);
    });

    return completer.future;
  }

  @override
  void dispose() {
    _fileUploadProgressStream.close();
    _fileCompressProgressStream.close();
    super.dispose();
  }
}
