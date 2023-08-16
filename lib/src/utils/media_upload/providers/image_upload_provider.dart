import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../media_optimiser_utils.dart';

class ImageUploadProvider extends CshChangeNotifier {
  bool isDataLoading = false;
  String? s3Url = "";

  static ImageUploadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ImageUploadProvider>(context, listen: listen);
  }

  uploadImage(BuildContext context, File file, {Function(String)? s3UrlCallback}) {
    isDataLoading = true;
    notifyListeners();
    String fileName = path.basename(file.path);
    MediaUploadUtil().uploadMedia(mediaFile: file, fileName: fileName, isVideoFile: false).then((value) {
      isDataLoading = false;
      notifyListeners();
      if (value.isNotEmpty) {
        s3Url = value;
        if (s3UrlCallback != null) {
          s3UrlCallback(s3Url!);
        }
      } else {
        CshSnackBar.error(context: context, message: "Something went wrong", snackBarPosition: SnackBarPosition.TOP);
      }
    }, onError: (error) {
      isDataLoading = false;
      notifyListeners();
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
    });
  }
}
