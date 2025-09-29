import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/media_upload_service_init_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../media_optimiser_utils.dart';

class ImageUploadProvider extends MediaUploadServiceInitProvider {
  bool isDataLoading = false;
  String? s3Url = "";

  ImageUploadProvider({this.s3Url});

  static ImageUploadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ImageUploadProvider>(context, listen: listen);
  }

  Future<String> uploadImage(File file) async {
    var isConnected = await ConnectivityUtil.checkConnectivity();
    if (isConnected == false) {
      return Future.error("No Internet Connection");
    }

    isDataLoading = true;
    notifyListeners();
    var completer = Completer<String>();
    String fileName = path.basename(file.path);
    MediaUploadUtil(service: mediaUploadService).uploadMediaWithType(mediaFile: file, fileName: fileName).then((value) {
      if (value.isNotEmpty) {
        s3Url = value;
        completer.complete(s3Url);
      } else {
        completer.completeError("Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(error);
    }).whenComplete(() {
      isDataLoading = false;
      notifyListeners();
    });
    return completer.future;
  }

  void clearImage() {
    s3Url = "";
    notifyListeners();
  }
}
