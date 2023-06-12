import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_resources/elss_service.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
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

  List<ChannelOptionData>? get otherChannelOptions => channelOptionResponse?.channelOptionData?.listOfChannelOption;

  ChannelOptionData? get yourChannelSuggestion => channelOptionResponse?.channelOptionData?.yourChannelSuggestion;

  ChannelOptionData? get defaultChannelSuggestion => channelOptionResponse?.channelOptionData?.defaultChannelOption;

  ChannelOptionData? get initialChannelSuggestion => channelOptionResponse?.channelOptionData?.initialChannelOption;

  _getBodyDataMapForPNA(List<ElssPart> dataList, int? optionId) {
    Map<String, dynamic> dataMap = {};
    List<Map<String, dynamic>> pnaMarkedMap = [];
    if (dataList.isNotEmpty) {
      for (var element in dataList) {
        if (element.isPnaSelected == true) {
          pnaMarkedMap.add({"sku": element.sku, "pn": element.partName, "pcl": element.partColour});
        }
      }
    }
    dataMap["pnaList"] = pnaMarkedMap;
    dataMap["oid"] = optionId;
    return dataMap;
  }

  Future<bool> markPNAStatus(String barcode, List<ElssPart> dataList, int? optionId) {
    var completer = Completer<bool>();
    Map<String, dynamic> bodyData = _getBodyDataMapForPNA(dataList, optionId);
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

  List<Map<String, dynamic>> getPostDataMapForElssOptionData(List<ElssPart> dataList) {
    List<Map<String, dynamic>> listDataMap = [];
    for (var element in dataList) {
      listDataMap.add({
        "sku": element.sku,
        "pn": element.partName,
      });
    }
    return listDataMap;
  }

  Future<bool> submitElssAcceptData(List<Map<String, dynamic>> partsDataList, String barcode, {int? optionId}) {
    var completer = Completer<bool>();

    try {
      ElssService.submitAcceptElss(partsDataList, barcode, optionId: optionId).listen((event) {
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

  List<ElssPart>? getDevicePartsForPna(List<ElssPart>? requestedPartList) {
    var repairPartList = requestedPartList
        ?.where((element) => element.actionConstant == ElssPartsSelectionOptions.repairRequired.id)
        .toList();
    return repairPartList;
  }

  void updateYourChannelSuggestionPNA(bool data, ElssPart item) {
    var requestedPartList = yourChannelSuggestion?.requestedParts;
    var selectedItemIndex =
        requestedPartList?.indexWhere((element) => element.sku == item.sku && element.partColour == item.partColour);
    if (selectedItemIndex != null && selectedItemIndex > -1) {
      requestedPartList![selectedItemIndex].isPnaSelected = data;
      notifyListeners();
    }
  }

  void updateOthersChannelSuggestionPNA(ElssPart item, bool data, int index) {
    var channelOption = otherChannelOptions?[index];
    var selectedIndex = channelOption?.requestedParts
        ?.indexWhere((element) => element.partColour == item.partColour && element.sku == item.sku);
    if (selectedIndex != null && selectedIndex > -1) {
      channelOption?.requestedParts?[selectedIndex].isPnaSelected = data;
      notifyListeners();
    }
  }
}
