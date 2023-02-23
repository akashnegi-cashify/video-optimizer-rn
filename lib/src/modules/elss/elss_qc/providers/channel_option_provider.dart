import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_resources/elss_service.dart';
import 'package:provider/provider.dart';
import '../../common_models/channel_option_response.dart';
import '../../common_models/elss_part.dart';

class ChannelOptionProvider extends CshChangeNotifier {
  static ChannelOptionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ChannelOptionProvider>(context, listen: listen);
  }

  ChannelOptionProvider(String barcode) {
    _fetchChannelOptions(barcode);
  }

  ChannelOptionResponse? channelOptionResponse;
  bool isOptionDataLoading = true;
  String errorOfChannel = "";

  _fetchChannelOptions(String barcode) {
    ElssService.getChannelOptions(barcode).listen((event) {
      if (event != null) {
        channelOptionResponse = event;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong!!";
      Logger.debug('mydebug------ChannelOptionProvider._fetchChannelOptions', [errorMessage]);
      errorOfChannel = errorMessage;
    }, onDone: () {
      isOptionDataLoading = false;
      notifyListeners();
    });
  }

  Future<bool> rejectElss(String barcode) {
    var completer = Completer<bool>();
    try {
      ElssService.rejectElss(barcode).listen((event) {
        if (event != null) {
          if (event.isSuccess == true) {
            completer.complete(true);
          } else {
            completer.completeError("Something Went Wrong!!");
          }
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  getBodyDataMapForPNA(List<ElssPart> dataList) {
    Map<String, dynamic> dataMap = {};
    List<Map<String, dynamic>> listDataMap = [];
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        if (element.isPnaSelected == true) {
          listDataMap.add({"sku": element.sku, "pn": element.partName, "pcl": element.partColour});
        }
      }
    }
    dataMap["pnaList"] = listDataMap;
    return dataMap;
  }

  Future<bool> markPNAStatus(String barcode, List<ElssPart> dataList) {
    var completer = Completer<bool>();
    Map<String, dynamic> bodyData = getBodyDataMapForPNA(dataList);
    try {
      ElssService.markPnaStatus(barcode, bodyData).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something Went Wrong");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong!!";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  checkIsItemSelectedForPNA(List<ElssPart> dataList) {
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        if (element.isPnaSelected == true) {
          return true;
        }
      }
    }
    return false;
  }

  checkIfImageIsAttachedToAllSkus(List<ElssPart> dataList) {
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        if (Validator.isNullOrEmpty(element.imageS3Url)) {
          return false;
        }
      }
    }
    return true;
  }

  List<Map<String, dynamic>> getPostDataMapForElssOptionData(List<ElssPart> dataList) {
    List<Map<String, dynamic>> listDataMap = [];
    for (var element in dataList) {
      listDataMap.add({
        "sku": element.sku,
        "pn": element.partName,
        "img": element.imageS3Url,
      });
    }
    return listDataMap;
  }

  Future<bool> submitElssAcceptData(
    List<Map<String, dynamic>> partsDataList,
    String barcode, {
    int? optionId,
    bool? isRubbingAllowed,
  }) {
    var completer = Completer<bool>();

    try {
      ElssService.submitAcceptElss(partsDataList, barcode, optionId: optionId, isRubbingAllowed: isRubbingAllowed)
          .listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something Went Wrong!!");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ChannelOptionProvider.submitElssAccpetData', [errorMessage]);
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  removePNASelectedItem(List<ElssPart> dataList) {
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        element.isPnaSelected = false;
      }
    }
  }

  removeAttachedImageOverBack(List<ElssPart> dataList) {
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        element.imageS3Url = null;
      }
    }
  }
}
