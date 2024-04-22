import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:provider/provider.dart';

import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../common_resources/elss_service.dart';

class ELssProviderQc extends CshChangeNotifier {
  static ELssProviderQc of(BuildContext context, {bool listen = true}) {
    return Provider.of<ELssProviderQc>(context, listen: listen);
  }

  ELssProviderQc(String barcode) {
    _getDeviceDetailsAndParts(barcode);
  }

  bool isDetailsDataLoading = true;
  ElssDeviceDetailsResponse? elssDeviceDetails;
  List<ElssPart> elssPartList = [];
  String detailsApiErrorMessage = "";

  _getDeviceDetailsAndParts(String scannedBarcode) {
    elssPartList.clear();
    ElssService.getDeviceDetailsWithParts(scannedBarcode).listen((event) {
      if (event != null) {
        elssDeviceDetails = event;
        if (!Validator.isListNullOrEmpty(event.deviceDetailsData?.repairPartList)) {
          int k = 0;
          for (var element in event.deviceDetailsData!.repairPartList!) {
            element.elssPartId = k;
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

  searchItemDataUpdate(int id, {required int actionConstant}) {
    Logger.debug('mydebug------ELssProvider.searchItemDataUpdate', [id, actionConstant]);
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      for (var element in elssPartList) {
        if (element.elssPartId == id) {
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
        sku: element.sku,
        isManualAdded: true,
        partColour: element.productColour,
        quantity: element.partQuantity,
        categoryCode: element.categoryCode,
        // mark default value is required for manually added parts
        actionConstant: ElssPartsSelectionOptions.optimizationRequired.id,
      );
      data.elssPartId = elssPartList.length;

      elssPartList.add(data);
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
          "acc": elssPartList[index].actionConstant,
          "cc": elssPartList[index].categoryCode,
        };
      });
    }

    dataMap["rprl"] = rprlList;
    dataMap["dbr"] = scannedBarcode;
    return dataMap;
  }

  Future<bool> submitPartsForLogic(String barcode) {
    Map<String, dynamic> bodyData = _getDetailsPostDatMap(barcode);
    var completer = Completer<bool>();
    try {
      ElssService.submitPartsForLogic(bodyData).listen((event) {
        if (event != null) {
          if (Validator.isTrue(event.isSuccess)) {
            completer.complete(event.data?.optionsAllowed);
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

  bool isRepairTypeDevice() {
    if (elssDeviceDetails?.deviceDetailsData?.isMarkRepairedDevice == null) {
      return false;
    }
    return elssDeviceDetails!.deviceDetailsData!.isMarkRepairedDevice!;
  }

  bool isNonRepairTypeDevice() {
    return !isRepairTypeDevice();
  }

  bool isElssPartsSelectedForRepair() {
    for (var elssPart in elssPartList) {
      if (elssPart.actionConstant != ElssPartsSelectionOptions.notRequired.id) {
        return true;
      }
    }
    return false;
  }
}
