import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/disputed_media_data_response.dart';
import '../resouces/dispute_image_capture_service.dart';

class DisputeImageCaptureProvider extends CshChangeNotifier {
  String? errorMessage;
  bool isDataLoading = true;
  DisputedMediaDataResponse? disputeDataModel;
  List<DisputeMediaInfoData> mediaInfoList = [];
  int totalMediaCount = 0, crossCheckMediaCount = 0;

  static DisputeImageCaptureProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DisputeImageCaptureProvider>(context, listen: listen);
  }

  DisputeImageCaptureProvider(String barcode) {
    _fetchDisputeMediaData(barcode);
  }

  _fetchDisputeMediaData(String barcode) {
    mediaInfoList.clear();
    // Map<String, dynamic> data = {
    //   "auditData": [
    //     {
    //       "ak": "8",
    //       "l": "Screen Cracked or Glass Broken",
    //       "ic": 1,
    //       "vc": 0,
    //       "sr": "Minor Scratches; normal signs of usage",
    //       "at": 1
    //     },
    //     {
    //       "ak": "5",
    //       "l": "Lines on Screen",
    //       "ic": 2,
    //       "vc": 1,
    //       "sr": "Screen Faded Along Corners or Discoloration",
    //       "at": 1
    //     },
    //     {"ak": "4", "l": "Screen Display Spot", "ic": 1, "vc": 0, "sr": "2 or less than 2 spots (small spot)", "at": 1},
    //     {"ak": "2", "l": "Screen Lifting", "ic": 1, "vc": 1, "at": 2}
    //   ],
    //   "r_id": "965f2943-2170-41da-891a-25f298e45a74",
    //   "pm": 1687337122603,
    //   "m": "Apple iPhone 8 64 GB",
    //   "b": "Motorola",
    //   "il": ["344663415178694"],
    //   "as": 1
    // };
    // disputeDataModel = DisputedMediaDataResponse.fromJson(data);
    //
    //
    //
    // isDataLoading = false;
    // notifyListeners();
    DisputeImageCaptureService.fetchDisputeImageCaptureData(barcode).listen((event) {
      if (event != null) {
        disputeDataModel = event;
        if (!Validator.isListNullOrEmpty(disputeDataModel?.mediaDataList)) {
          for (var element in disputeDataModel!.mediaDataList!) {
            element.imageS3Urls = List.generate(element.imageCount ?? 0, (index) => "").toList();
            element.videoS3urls = List.generate(element.videoCount ?? 0, (index) => VideoUrlData("")).toList();
            mediaInfoList.add(element);
          }
          _getTotalMediaCount();
        }
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------DisputeImageCaptureProvider._fetchDisputeMediaData', [em]);
      errorMessage = em;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  checkAuditAlreadyDone(Function() onAuditAlreadyDone) {
    if (disputeDataModel?.auditStatus != null && disputeDataModel!.auditStatus! == 1) {
      onAuditAlreadyDone();
    }
  }

  _getTotalMediaCount() {
    for (var element in mediaInfoList) {
      totalMediaCount = totalMediaCount + element.getTotalMediaCount();
    }
  }

  bool checkSubmitButtonStatus() {
    int mediaCounter = 0;
    for (var element in mediaInfoList) {
      for (var imageData in element.imageS3Urls!) {
        if (imageData.isNotEmpty) {
          mediaCounter = mediaCounter + 1;
        }
      }
      for (var videoData in element.videoS3urls!) {
        if (videoData.videoUrl.isNotEmpty) {
          mediaCounter = mediaCounter + 1;
        }
      }
    }
    Logger.debug('mydebug------DisputeImageCaptureProvider.checkSubmitButtonStatus', [mediaCounter]);
    Logger.debug('mydebug------DisputeImageCaptureProvider.checkSubmitButtonStatus', [totalMediaCount]);
    return totalMediaCount == mediaCounter;
  }

  Future<bool> subDisputeMediaData(String barcode) {
    var completer = Completer<bool>();
    try {
      DisputeImageCaptureService.submitDisputeMediaData(barcode: barcode, bodyData: _getSubmitDataMap(barcode)).listen(
          (event) {
        if (Validator.isTrue(event?.isSuccess)) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------DisputeImageCaptureProvider.subDisputeMediaData', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  _getSubmitDataMap(String barcode) {
    // Build per-audit media entries
    final List<Map<String, dynamic>> dataMapList = [];
    final List<String> allImages = [];
    final List<String> allVideos = [];

    for (var element in mediaInfoList) {
      final images = element.imageS3Urls ?? [];
      final videos = element.videoS3urls ?? [];

      dataMapList.add({
        "auditKey": element.auditKey,
        "auditType": element.at,
        "images": images,
        "videos": videos.map((e) => e.videoUrl).toList(),
      });

      allImages.addAll(images.where((e) => e.isNotEmpty));
      allVideos.addAll(videos.map((e) => e.videoUrl).where((e) => e.isNotEmpty));
    }

    final bodyDataMap = <String, dynamic>{
      // List<SourceAuditAppMediaRequest>
      "data": dataMapList,
      // Additional top-level fields
      "apiKey": disputeDataModel?.apiKey,
      "auditType": disputeDataModel?.auditType,
      "images": allImages,
      "videos": allVideos,
    };
    Logger.debug('mydebug------DisputeImageCaptureProvider._getSubmitDataMap', [bodyDataMap]);
    return bodyDataMap;
  }
}
