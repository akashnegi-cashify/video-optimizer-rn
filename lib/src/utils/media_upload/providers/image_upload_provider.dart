import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../media_optimiser_utils.dart';

class ImageUploadProvider extends CshChangeNotifier {
  bool isDataLoading = false;
  String? s3Url = "";
  ImageUploadServiceType serviceType;

  ImageUploadProvider({this.serviceType = ImageUploadServiceType.image_optimize});

  static ImageUploadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ImageUploadProvider>(context, listen: listen);
  }

  Future<String> uploadImage(File file) {
    isDataLoading = true;
    notifyListeners();
    var completer = Completer<String>();
    String fileName = path.basename(file.path);
    MediaUploadUtil(service: serviceType.service).uploadMediaWithType(mediaFile: file, fileName: fileName).then((value) {
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
}
