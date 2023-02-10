import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_models/part_device_list.dart';
import '../../common_resources/elss_service.dart';

class AddPartListProviderQc extends CshChangeNotifier {
  AddPartListProviderQc(String barcode) {
    _getAddPartDataList(barcode);
  }

  static AddPartListProviderQc of(BuildContext context, {bool listen = true}) {
    return Provider.of<AddPartListProviderQc>(context, listen: listen);
  }

  bool isPartListLoading = true;
  List<PartItemDataResponse> addPartsDataList = [];

  _getAddPartDataList(String scannedBarcode) {
    addPartsDataList.clear();
    ElssService.getAddPartItemList(scannedBarcode).listen((event) {
      if (event != null) {
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
