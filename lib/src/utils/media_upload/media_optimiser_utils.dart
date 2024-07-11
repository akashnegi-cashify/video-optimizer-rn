import 'dart:async';
import 'dart:io' as io;
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/image_optimiser_service.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_uploader_service.dart';

import 'models/presigned_url_response.dart';

class MediaUploadUtil {
  MediaUploadUtil._private();

  BaseService? service;

  static final MediaUploadUtil _instance = MediaUploadUtil._private();

  factory MediaUploadUtil({BaseService? service}) {
    Logger.debug('mydebug-----MediaUploadUtil.MediaUploadUtil factory method', [service]);
    if (service != null) {
      _instance.service = service;
    } else {
      _instance.service = ImageOptimizerService();
    }
    return _instance;
  }

  //Get Pre-Signed url to upload media
  _getPreSignedUrlForUpload(
      {required String fileName,
      required String fileFormat,
      required Function(String error) onError,
      required Function(PreSignedUrlResponse? preSignedUrlResponse) onSuccess}) {
    MediaUploaderService.getPreSignedUrl(fileName: fileName, fileFormat: fileFormat, service: service).listen((event) {
      if (event != null) {
        onSuccess(event);
      } else {
        onError("Something went wrong");
      }
    }, onError: (error) {
      String errorMessage;
      if (error?.cause is SocketException) {
        errorMessage = "No Internet Connection";
      } else {
        errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      }
      Logger.debug('mydebug------ImageUploadUtil.getPreSignedUrlForUpload', [errorMessage]);
      onError(errorMessage);
    });
  }

  _getMediaS3Url(
      {required String transactionId,
      required Function(String) onError,
      required Function(String imageUrl) onSuccess}) {
    MediaUploaderService.getImageAcknowledged(transactionId: transactionId, service: service).listen((event) {
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

  Future<String> uploadMediaWithType(
      {required io.File mediaFile,
      required String fileName,
      MediaContentType contentType = MediaContentType.webp,
      Function(int progress)? onProgress}) {
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

          try {
            final client = io.HttpClient();
            var request = await client.putUrl(Uri.parse(url!));

            int length = mediaFile.lengthSync();
            request.headers.add("content-type", contentType.value);
            request.headers.add("Cache-Control", "no-cache");
            request.contentLength = length;

            final stream = mediaFile.openRead();
            int byteCount = 0;
            Stream<List<int>> stream2 = stream.transform(
              StreamTransformer.fromHandlers(
                handleData: (data, sink) {
                  byteCount += data.length;
                  int percentage = ((byteCount / length) * 100).toInt();
                  onProgress?.call(percentage);
                  Logger.debug('FileUploader.uploadFile', [byteCount]);
                  sink.add(data);
                },
                handleError: (error, stack, sink) {},
                handleDone: (sink) {
                  sink.close();
                },
              ),
            );

            await request.addStream(stream2);

            var response = await request.close();
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
          } on io.SocketException catch (error) {
            String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
            Logger.debug('Http Timeout Exception at backend $error');
            completer.completeError(em);
          } on io.HttpException catch (error) {
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
        onError: (String error) {
          completer.completeError(error);
        },
      );
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
