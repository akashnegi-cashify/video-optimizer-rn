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

  String? _searchedQuery;

  static AddPartListProviderQc of(BuildContext context, {bool listen = true}) {
    return Provider.of<AddPartListProviderQc>(context, listen: listen);
  }

  set searchedQuery(String? query) {
    _searchedQuery = query;
    notifyListeners();
  }

  String? get searchedQuery => _searchedQuery;

  bool isPartListLoading = true;
  List<PartItemDataResponse> _addPartsDataList = [];

  List<PartItemDataResponse> get addPartsDataList {
    if (Validator.isNullOrEmpty(_searchedQuery)) {
      return _addPartsDataList;
    }
    return _addPartsDataList
        .where((element) => element.productName!.toLowerCase().contains(_searchedQuery!.toLowerCase()))
        .toList();
  }

  _getAddPartDataList(String scannedBarcode) {
    _addPartsDataList.clear();
    ElssService.getAddPartItemList(scannedBarcode).listen((event) {
      if (event != null) {
        if (!Validator.isListNullOrEmpty(event.partDataList)) {
          int k = 0;
          for (var element in event.partDataList!) {
            element.partId = k;
            _addPartsDataList.add(element);
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

  List<PartItemDataResponse> getSelectedParts() {
    List<PartItemDataResponse> dataList = [];
    if (!Validator.isListNullOrEmpty(_addPartsDataList)) {
      for (var element in _addPartsDataList) {
        if (element.isCardSelected ?? false) {
          dataList.add(element);
        }
      }
    }
    return dataList;
  }

  void onPartItemSelected(PartItemDataResponse addPartsData, bool isSelected) {
    for (var item in _addPartsDataList) {
      if (item.partId == addPartsData.partId) {
        item.isCardSelected = isSelected;
        break;
      }
    }
    notifyListeners();
  }
}
