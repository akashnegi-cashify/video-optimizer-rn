import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../media_optimiser_utils.dart';

class VideoUploadProvider extends CshChangeNotifier {
  bool isDataLoading = false;
  String? videoS3Url;
  String? videoThumbnailImagePath;

  static VideoUploadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<VideoUploadProvider>(context, listen: listen);
  }

  File? get videoThumbnailFile =>
      (!Validator.isNullOrEmpty(videoThumbnailImagePath)) ? File(videoThumbnailImagePath!) : null;

  uploadVideo(BuildContext context, File file, {Function(String)? s3UrlCallback}) async {
    isDataLoading = true;
    notifyListeners();
    MediaInfo? info = await VideoCompress.compressVideo(file.path,
        deleteOrigin: true, includeAudio: false, quality: VideoQuality.Res640x480Quality);
    if (info?.file != null) {
      file = info!.file!;
    }

    String fileName = path.basename(file.path);
    MediaUploadUtil().uploadMedia(mediaFile: file, fileName: fileName, isVideoFile: true).then((value) async {
      if (value.isNotEmpty) {
        videoS3Url = value;
        videoThumbnailImagePath = await _getVideoThumbnail(videoS3Url!);
        if (s3UrlCallback != null) {
          s3UrlCallback(videoS3Url!);
        }
      } else {
        CshSnackBar.error(context: context, message: "Something went wrong", snackBarPosition: SnackBarPosition.TOP);
      }
      isDataLoading = false;
      notifyListeners();
    }, onError: (error) {
      isDataLoading = false;
      notifyListeners();
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
    });
  }

  Future<String?> _getVideoThumbnail(String s3Url) async {
    return await VideoThumbnail.thumbnailFile(
      video: s3Url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 120,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );
  }
}
