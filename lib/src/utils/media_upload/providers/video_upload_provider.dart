import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/video_compression_mixin.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../media_optimiser_utils.dart';

class VideoUploadProvider extends CshChangeNotifier with VideoCompressionMixin {
  bool isDataLoading = false;
  String? videoS3Url;
  String? _videoThumbnailImagePath;

  static VideoUploadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<VideoUploadProvider>(context, listen: listen);
  }

  File? get videoThumbnailFile =>
      (!Validator.isNullOrEmpty(_videoThumbnailImagePath)) ? File(_videoThumbnailImagePath!) : null;

  Future<(String, String?)> uploadVideo(File file, {bool isCompressed = true}) async {
    var isConnected = await ConnectivityUtil.checkConnectivity();
    if (!isConnected) {
      return Future.error("No Internet connection");
    }
    isDataLoading = true;
    notifyListeners();
    var completer = Completer<(String, String?)>();

    if (isCompressed) {
      var compressedFile = await _getCompressedFile(file.path);
      if (compressedFile != null) {
        file = compressedFile;
      }
    }

    String fileName = path.basename(file.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: file, fileName: fileName, contentType: MediaContentType.mp4).then(
        (value) async {
      if (value.isNotEmpty) {
        videoS3Url = value;
        _videoThumbnailImagePath = await _getVideoThumbnail(file.path);
        completer.complete((value, _videoThumbnailImagePath));
      } else {
        completer.completeError("Something went wrong");
      }
    }, onError: (error) {
      Logger.debug('mydebug-----VideoUploadProvider.uploadVideo', [error]);
      completer.completeError(error);
    }).whenComplete(() {
      isDataLoading = false;
      notifyListeners();
    });
    return completer.future;
  }

  Future<File?> _getCompressedFile(String filePath) async {
    var completer = Completer<File?>();
    VideoPlayerController controller = VideoPlayerController.file(File(filePath));
    await controller.initialize();
    String videoConfig =
        '{"videoCodec":"libx264","videoPreset":"superfast","crf":30,"fontSize":24,"fontColor":"white","borderColor":"black","addTimeStamp":true,"isRemoveAudio":true}';
    compressVideo(filePath, controller.value.duration.inSeconds, config: videoConfig).then((compressedVideoPath) {
      completer.complete(File(compressedVideoPath));
    }, onError: (error) async {
      var file = File(filePath);
      if (file.path.contains(".temp")) {
        file = await _getRenamedFile(filePath);
      }
      completer.complete(file);
    });
    return completer.future;
  }

  Future<String?> _getVideoThumbnail(String filePath) async {
    return await VideoThumbnail.thumbnailFile(
      video: filePath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 120,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );
  }

  Future<File> _getRenamedFile(String path) async {
    var file = File(path);
    String oldExtension = path.split('.').last;
    String newPath = path.replaceAll(oldExtension, "mp4");
    file = await file.rename(newPath);
    return file;
  }
}
