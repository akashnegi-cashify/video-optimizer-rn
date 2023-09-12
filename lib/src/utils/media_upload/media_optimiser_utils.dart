import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:http/http.dart' as http;

import 'media_uploader_service.dart';
import 'models/presigned_url_response.dart';

class MediaUploadUtil {
  MediaUploadUtil._private();

  static final MediaUploadUtil _instance = MediaUploadUtil._private();

  factory MediaUploadUtil() {
    return _instance;
  }

  //Get Pre-Signed url to upload media
  _getPreSignedUrlForUpload(
      {required String fileName,
      required String fileFormat,
      required Function(String) onError,
      required Function(PreSignedUrlResponse? preSignedUrlResponse) onSuccess}) {
    MediaUploaderService.getPreSignedUrl(fileName: fileName, fileFormat: fileFormat).listen((event) {
      if (event != null) {
        onSuccess(event);
      } else {
        onError("Something went wrong");
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      onError(em);
      Logger.debug('mydebug------ImageUploadUtil.getPreSignedUrlForUpload', [em]);
    });
  }

  _getMediaS3Url(
      {required String transactionId,
      required Function(String) onError,
      required Function(String imageUrl) onSuccess}) {
    MediaUploaderService.getImageAcknowledged(transactionId: transactionId).listen((event) {
      if (!Validator.isNullOrEmpty(event?.imageUrl)) {
        onSuccess(event!.imageUrl!);
      } else {
        onError("Something went wrong");
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ImageUploadUtil.getPreSignedUrlForUpload', [em]);
      onError(em);
    });
  }

  // Future<String> uploadMedia({required File mediaFile, required String fileName, bool? isVideoFile = false}) {
  //   var completer = Completer<String>();
  //   String fileFormat = mediaFile.path.split(".").last;
  //   try {
  //     _getPreSignedUrlForUpload(
  //       fileName: fileName,
  //       fileFormat: fileFormat,
  //       onSuccess: (PreSignedUrlResponse? preSignedUrlResponse) async {
  //         var date1 = DateTime.now();
  //         String? preSignedUrl = preSignedUrlResponse?.preSignedUrl;
  //         String? transactionId = preSignedUrlResponse?.transactionId;
  //         if (!Validator.isNullOrEmpty(preSignedUrl)) {
  //           try {
  //             Uri url = Uri.parse(preSignedUrl!);
  //             List<int> imagesBytes = mediaFile.readAsBytesSync();
  //             var response = await http.put(url,
  //                 body: imagesBytes,
  //                 headers: {"content-type": (Validator.isTrue(isVideoFile)) ? "video/mp4" : "image/jpeg"});
  //             if (response.statusCode == 200) {
  //               var date2 = DateTime.now();
  //               Logger.debug('mydebug------ImageUploadUtil.uploadImage', ["Image Uploaded Successfully", date2.difference(date1)]);
  //               _getMediaS3Url(
  //                 transactionId: transactionId ?? "",
  //                 onError: (error) {
  //                   completer.completeError(error);
  //                 },
  //                 onSuccess: (String imageUrl) {
  //                   Logger.debug('mydebug-----MediaUploadUtil.uploadMedia---url-----', [imageUrl]);
  //                   completer.complete(imageUrl);
  //                 },
  //               );
  //             } else {
  //               completer.completeError("error");
  //             }
  //           } on TimeoutException catch (error) {
  //             String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
  //             Logger.debug('Http Timeout Exception at backend $error');
  //             completer.completeError(em);
  //           } on SocketException catch (error) {
  //             String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
  //             Logger.debug('Http Timeout Exception at backend $error');
  //             completer.completeError(em);
  //           } on HttpException catch (error) {
  //             String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
  //             Logger.debug('Http Timeout Exception at backend $error');
  //             completer.completeError(em);
  //           } on Error catch (error) {
  //             String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
  //             Logger.debug('Http Timeout Exception at backend $error');
  //             completer.completeError(em);
  //           } catch (e) {
  //             completer.completeError(e.toString());
  //           }
  //         } else {
  //           completer.completeError("No Pre-Signed URL found");
  //         }
  //       },
  //       onError: (error) {
  //         completer.completeError(error);
  //       },
  //     );
  //   } catch (e) {
  //     completer.completeError(e.toString());
  //   }
  //
  //   return completer.future;
  // }

  Future<String> uploadMediaWithType(
      {required File mediaFile, required String fileName, MediaContentType contentType = MediaContentType.webp}) {
    var completer = Completer<String>();
    String fileFormat = mediaFile.path.split(".").last;
    try {
      _getPreSignedUrlForUpload(
        fileName: fileName,
        fileFormat: fileFormat,
        onSuccess: (PreSignedUrlResponse? preSignedUrlResponse) async {
          final String? transactionId = preSignedUrlResponse?.transactionId;
          final String? url = preSignedUrlResponse?.preSignedUrl;
          if (Validator.isNullOrEmpty(url)) {
            completer.completeError("No Pre-Signed Url found");
            return;
          }

          var counter = 0;
          final streamedRequest = http.StreamedRequest('PUT', Uri.parse(url!))
            ..headers.addAll({'Cache-Control': 'no-cache', "content-type": contentType.value});
          streamedRequest.contentLength = await mediaFile.length();

          Logger.debug('mydebug-----MediaUploadUtil.uploadMediaWithType contentLenght', [streamedRequest.contentLength]);
          mediaFile.openRead().listen((chunk) {
            counter += chunk.length;
            Logger.debug('mydebug-----MediaUploadUtil.uploadMediaWithType chunk Lenght', [counter]);
            streamedRequest.sink.add(chunk);
          }, onDone: () {
            streamedRequest.sink.close();
          });

          try {
            var response = await streamedRequest.send();
            if (response.statusCode == 200) {
              Logger.debug('mydebug------ImageUploadUtil.uploadImage', ["Image Uploaded Successfully"]);
              _getMediaS3Url(
                transactionId: transactionId ?? "",
                onError: (error) {
                  completer.completeError(error);
                },
                onSuccess: (String imageUrl) {
                  Logger.debug('mydebug-----MediaUploadUtil.uploadMedia---url-----', [imageUrl]);
                  completer.complete(imageUrl);
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
