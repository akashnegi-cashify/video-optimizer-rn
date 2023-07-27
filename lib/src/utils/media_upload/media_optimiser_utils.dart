import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'media_uploader_service.dart';
import 'models/presigned_url_response.dart';

class MediaUploadUtil {
  MediaUploadUtil._private();

  static MediaUploadUtil? _instance;

  factory MediaUploadUtil() {
    if (_instance == null) {
      _instance = MediaUploadUtil._private();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  PreSignedUrlResponse? _preSignedUrlData;
  String? _uploadedImageUrl;

  //Get Pre-Signed url to upload media
  _getPreSignedUrlForUpload(
      {required String fileName,
      required String fileFormat,
      required Function(String) onError,
      required Function() onSuccess}) {
    MediaUploaderService.getPreSignedUrl(fileName: fileName, fileFormat: fileFormat).listen((event) {
      if (event != null) {
        _preSignedUrlData = event;
        onSuccess();
      } else {
        onError("Something went wrong");
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      onError(em);
      Logger.debug('mydebug------ImageUploadUtil.getPreSignedUrlForUpload', [em]);
    });
  }

  _getMediaS3Url({required String transactionId, required Function(String) onError, required Function() onSuccess}) {
    MediaUploaderService.getImageAcknowledged(transactionId: transactionId).listen((event) {
      if (!Validator.isNullOrEmpty(event?.imageUrl)) {
        _uploadedImageUrl = event!.imageUrl!;
        onSuccess();
      } else {
        onError("Something went wrong");
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ImageUploadUtil.getPreSignedUrlForUpload', [em]);
      onError(em);
    });
  }

  Future<String> uploadMedia({required File mediaFile, required String fileName, bool? isVideoFile = false}) {
    var completer = Completer<String>();
    String fileFormat = mediaFile.path.split(".").last;
    try {
      _getPreSignedUrlForUpload(
        fileName: fileName,
        fileFormat: fileFormat,
        onSuccess: () async {
          if (!Validator.isNullOrEmpty(_preSignedUrlData?.preSignedUrl)) {
            try {
              Uri url = Uri.parse(_preSignedUrlData!.preSignedUrl!);
              List<int> imagesBytes = mediaFile.readAsBytesSync();
              var response = await http.put(url,
                  body: imagesBytes,
                  headers: {"content-type": (Validator.isTrue(isVideoFile)) ? "video/mp4" : "image/jpeg"});
              if (response.statusCode == 200) {
                Logger.debug('mydebug------ImageUploadUtil.uploadImage', ["Image Uploaded Successfully"]);
                _getMediaS3Url(
                  transactionId: _preSignedUrlData?.transactionId ?? "",
                  onError: (error) {
                    completer.completeError(error);
                  },
                  onSuccess: () {
                    Logger.debug('mydebug-----MediaUploadUtil.uploadMedia---url-----', [_uploadedImageUrl]);
                    completer.complete(_uploadedImageUrl ?? "");
                  },
                );
              } else {
                completer.completeError("error");
              }
            } on TimeoutException catch (error) {
              String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
              Logger.debug('Http Timeout Exception at backend $error');
              completer.completeError(em);
            } on SocketException catch (error) {
              String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
              Logger.debug('Http Timeout Exception at backend $error');
              completer.completeError(em);
            } on HttpException catch (error) {
              String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
              Logger.debug('Http Timeout Exception at backend $error');
              completer.completeError(em);
            } on Error catch (error) {
              String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
              Logger.debug('Http Timeout Exception at backend $error');
              completer.completeError(em);
            } catch (e) {
              completer.completeError(e.toString());
            }
          } else {
            completer.completeError("No Pre-Signed URL found");
          }
        },
        onError: (error) {
          completer.completeError(error);
        },
      );
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }
}
