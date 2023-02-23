import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_models/part_device_list.dart';
import '../../common_resources/elss_service.dart';

class AddPartListProviderTrc extends CshChangeNotifier {
  static AddPartListProviderTrc of(BuildContext context, {bool listen = true}) {
    return Provider.of<AddPartListProviderTrc>(context, listen: listen);
  }

  AddPartListProviderTrc(String barcode) {
    _getAddPatDataList(barcode);
  }

  bool isPartListLoading = true;
  PartDeviceListResponse? partDeviceListResponse;
  List<PartItemDataResponse> addPartsDataList = [];

  _getAddPatDataList(String scannedBarcode) {
    addPartsDataList.clear();
    ElssService.getPartItemList(scannedBarcode).listen((event) {
      if (event != null) {
        partDeviceListResponse = event;
        if (!Validator.isListNullOrEmpty(event.partDataList)) {
          int k = 0;
          for (var element in event.partDataList!) {
            element.partId = k;
            addPartsDataList.add(element);
            k++;
          }
        }
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ELssProvider.getAddPatDataList', [errorMessage]);
    }, onDone: () {
      isPartListLoading = false;
      notifyListeners();
    });
  }

  selectedPartFromList(int pId, bool isSelected) {
    if (!Validator.isListNullOrEmpty(addPartsDataList)) {
      for (var element in addPartsDataList) {
        if (element.partId == pId) {
          element.isCardSelected = isSelected;
          break;
        }
      }
    }
    notifyListeners();
  }

  List<PartItemDataResponse> getSelectedParts() {
    List<PartItemDataResponse> dataList = [];
    if (!Validator.isListNullOrEmpty(addPartsDataList)) {
      for (var element in addPartsDataList) {
        if (element.isCardSelected ?? false) {
          dataList.add(element);
        }
      }
    }
    return dataList;
  }
}
