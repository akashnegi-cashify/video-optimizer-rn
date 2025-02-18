import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/channel/native_communication.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/media_upload_service_init_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../media_optimiser_utils.dart';

class VideoUploadProvider extends MediaUploadServiceInitProvider {
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
      var mediaInfo = await NativeCommunication.compressVideo(file.path, includeAudio: false);
      if (mediaInfo?.file != null) {
        file = mediaInfo!.file!;
      }
    }

    String fileName = path.basename(file.path);
    MediaUploadUtil(service: mediaUploadService).uploadMediaWithType(mediaFile: file, fileName: fileName, contentType: MediaContentType.mp4).then(
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
}
