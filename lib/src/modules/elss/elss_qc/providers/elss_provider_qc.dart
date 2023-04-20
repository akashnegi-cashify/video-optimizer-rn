import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_option_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/elss_part_submit_response.dart';
import '../../common_models/part_device_list.dart';
import '../../common_models/parts_elss_action.dart';
import '../../common_models/submit_parts_logic_model.dart';
import '../../common_models/upload_fault_images_response.dart';
import '../../common_resources/elss_action.dart';
import '../../common_resources/elss_service.dart';

class ELssProviderQc extends CshChangeNotifier {
  static ELssProviderQc of(BuildContext context, {bool listen = true}) {
    return Provider.of<ELssProviderQc>(context, listen: listen);
  }

  ELssProviderQc(String barcode) {
    _getDeviceDetailsAndParts(barcode);
    _getElssPartsAction();
  }

  bool isDetailsDataLoading = true;
  bool isRubbingApplicable = false;
  ElssDeviceDetailsResponse? elssDeviceDetails;
  ElssOptionResponse? elssOptionResponse;
  List<OptionResponse> productOptionList = [];
  List<ElssPart> elssPartList = [];
  UploadFaultImagesResponse? uploadFaultImagesResponse;
  ElssPartSubmitResponse? elssPartSubmitResponse;
  PartsElssActionResponse? elssPartActionResponse;
  String detailsApiErrorMessage = "";
  SubmitPartsLogicResponse? submitPatsLogicData;

  _getElssPartsAction() {
    ElssService.getElssActionForParts().listen((event) {
      if (event != null) {
        elssPartActionResponse = event;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ELssProviderQc._getElssPartsAction', [errorMessage]);
    }, onDone: () {
      notifyListeners();
    });
  }

  _getDeviceDetailsAndParts(String scannedBarcode) {
    elssPartList.clear();
    ElssService.getDeviceDetailsWithParts(scannedBarcode).listen((event) {
      if (event != null) {
        elssDeviceDetails = event;
        if (!Validator.isListNullOrEmpty(event.deviceDetailsData?.repairPartList)) {
          int k = 0;
          for (var element in event.deviceDetailsData!.repairPartList!) {
            element.elssPartId = k;
            element.action = ElssAction.NOT_REQUIRED.value;
            elssPartList.add(element);
            k++;
          }
        }
      }
      isDetailsDataLoading = false;
      notifyListeners();
    }, onError: (error) {
      String apiErrorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
      detailsApiErrorMessage = apiErrorMessage;
      Logger.debug('mydebug------ELssProviderQc._getDeviceDetailsAndParts', [apiErrorMessage]);
      isDetailsDataLoading = false;
      notifyListeners();
    });
  }

  searchItemDataUpdate(int id, {String? action, int? actionConstant}) {
    Logger.debug('mydebug------ELssProvider.searchItemDataUpdate', [id, action]);
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      for (var element in elssPartList) {
        if (element.elssPartId == id && !Validator.isNullOrEmpty(action)) {
          element.action = action!;
          element.actionConstant = actionConstant;
          break;
        }
      }
    }
    notifyListeners();
  }

  addNewPartsFromAddParts(List<PartItemDataResponse> dataList) {
    for (var element in dataList) {
      ElssPart data = ElssPart(
        partName: element.productName,
        action: ElssAction.REPAIRABLE.value,
        actionConstant: elssPartActionResponse?.actionsData?.required,
        sku: element.sku,
        isManualAdded: true,
        partColour: element.productColour,
        quantity: element.partQuantity,
      );
      data.elssPartId = elssPartList.length + 1;
      data.partsImageList = ["", "", "", "", "", ""];

      elssPartList.add(data);
    }
    notifyListeners();
  }

  removeExternalAddedPart(int id) {
    elssPartList.removeWhere((element) => element.elssPartId == id);
    int k = 0;
    for (var element in elssPartList) {
      element.elssPartId = k;
      k++;
    }
    notifyListeners();
  }

  _getDetailsPostDatMap(String scannedBarcode) {
    Map<String, dynamic> dataMap = {};

    List<Map<String, dynamic>> rprlList = [];
    if (elssPartList.isNotEmpty) {
      rprlList = List.generate(elssPartList.length, (index) {
        return {
          "sku": elssPartList[index].sku,
          "pn": elssPartList[index].partName,
          "pcl": elssPartList[index].partColour,
          "ac": elssPartList[index].action,
          "acc": elssPartList[index].actionConstant
        };
      });
    }

    dataMap["rprl"] = rprlList;
    dataMap["isr"] = isRubbingApplicable;
    dataMap["dbr"] = scannedBarcode;
    return dataMap;
  }

  _getBodyDataMapForPNA(List<ElssPart> markedPnaList) {
    Map<String, dynamic> dataMap = {};
    List<Map<String, dynamic>> listDataMap = [];
    if (markedPnaList.isNotEmpty) {
      for (var element in markedPnaList) {
        listDataMap.add({"sku": element.sku, "pn": element.partName, "pcl": element.partColour});
      }
    }
    dataMap["pnaList"] = listDataMap;
    return dataMap;
  }

  Future<bool> markPNAStatus(String barcode, List<ElssPart> markedPnaList) {
    var completer = Completer<bool>();
    Map<String, dynamic> bodyData = _getBodyDataMapForPNA(markedPnaList);
    try {
      ElssService.markPnaStatus(barcode, bodyData).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something Went Wrong!!");
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

  Future<bool> submitPartsForLogic(String barcode) {
    Map<String, dynamic> bodyData = _getDetailsPostDatMap(barcode);
    var completer = Completer<bool>();
    try {
      ElssService.submitPartsForLogic(bodyData).listen((event) {
        if (event != null) {
          submitPatsLogicData = event;
          if (Validator.isTrue(event.isSuccess)) {
            completer.complete(true);
          } else {
            completer.completeError("Something Went Wrong");
          }
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

  setIsRubbingValue(bool value) {
    isRubbingApplicable = value;
    notifyListeners();
  }

  List<ElssPart> getPartListForPna() {
    return elssPartList.where((element) => element.action == ElssAction.REPAIRABLE.value).toList();
  }
}
