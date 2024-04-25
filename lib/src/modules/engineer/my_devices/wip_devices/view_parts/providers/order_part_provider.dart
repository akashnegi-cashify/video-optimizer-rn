import 'dart:async';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/utils/string_utils.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

import '../../../../models/retreived_part_required_list_reponse.dart';
import '../models/order_engineer_part.dart';

class OrderPartProvider extends CshChangeNotifier {
  final String? deviceBarcode;

  String? _query;

  final List<DropDownItem> partTypeList = [];

  String? get query => _query;

  set query(String? value) {
    _query = value;
    notifyListeners();
  }

  List<OrderEngineerPart> get displayList => _originalDataList
      .where((element) => (element.partName.containsIgnoreCase(query) || element.sku.containsIgnoreCase(query)))
      .toList();

  List<OrderEngineerPart> _originalDataList = [];

  OrderPartProvider(this.deviceBarcode) {
    for (var element in ElssPartsSelectionOptions.values) {
      if (element != ElssPartsSelectionOptions.notRequired) {
        partTypeList.add(DropDownItem(element.id.toString(), element.value));
      }
    }
  }

  getListParts(Function(String errorMessage) handleError, L10n l10n) {
    _originalDataList = [];

    EngineerAPIService.listDeviceParts(deviceBarcode).listen((event) {
      _originalDataList = event?.partDataList ?? [];

      if (event?.errorMsg != null) {
        handleError(event!.errorMsg!);
      }
    }, onError: (e, s) {
      Logger.debug('mydebug-----OrderPartProvider.getListParts', [s]);
      handleError(ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong);
    }, onDone: () {
      notifyListeners();
    });
  }

  updateDataForNIndex(OrderEngineerPart item, int update) {
    int searchedIndex =
        _originalDataList.indexWhere((element) => element.sku == item.sku && element.partColor == item.partColor);
    if (searchedIndex > -1) {
      var item = _originalDataList[searchedIndex];
      item.orderQuantity = (item.orderQuantity ?? 0) + update;
      if (item.orderQuantity == 0) {
        item.selectedPartType = null;
      }
      notifyListeners();
    }
  }

  void orderParts(L10n l10n, {required Function(String errorMessage) handleError, required VoidCallback callback}) {
    EngineerAPIService.orderDeviceParts(deviceBarcode, getSelectedPartList()).listen((event) {
      if (event?.isSuccess == true) {
        callback();
      } else {
        handleError(event?.errorMsg ?? l10n.somethingWentWrong);
      }
    }, onError: (error, stacktrace) {
      handleError(ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
    });
  }

  bool isDismissed(DropDownItem? selectedPartType) {
    if (selectedPartType == null) {
      return true;
    }

    if (selectedPartType.id == ElssPartsSelectionOptions.repairRequired.id.toString()) {
      return false;
    } else {
      return true;
    }
  }

  int? getMaxQuantity(DropDownItem? selectedPartType) {
    if (selectedPartType == null) {
      return null;
    }

    if (selectedPartType.id == ElssPartsSelectionOptions.repairRequired.id.toString()) {
      return null;
    } else {
      return 1;
    }
  }

  void updatePartTypeSelection(OrderEngineerPart part, DropDownItem? value) {
    int searchedIndex =
        _originalDataList.indexWhere((element) => element.sku == part.sku && element.partColor == part.partColor);
    if (searchedIndex > -1) {
      _originalDataList[searchedIndex].selectedPartType = value;
      notifyListeners();
    }
  }

  List<OrderEngineerPart> getSelectedPartList() {
    return _originalDataList.where((element) => (element.orderQuantity ?? 0) > 0).toList();
  }

  Future<RetrievedPartRequiredResponse> getRetrievedPartsData() {
    List<Map<String, dynamic>> dataList = [];
    for (var value in _originalDataList) {
      if (value.orderQuantity != null &&
          value.orderQuantity! > 0 &&
          value.selectedPartType?.id == ElssPartsSelectionOptions.repairRequired.id.toString()) {
        dataList.add({"prn": value.partName, "ccd": value.categoryCode});
      }
    }

    if (dataList.isEmpty) {
      return Future.error("No data Found");
    }
    var completer = Completer<RetrievedPartRequiredResponse>();
    try {
      EngineerAPIService.fetchRequiredPartsListingByDID({"pd": dataList}).listen((event) {
        if (!Validator.isListNullOrEmpty(event?.data?.partList)) {
          completer.complete(event!);
        } else {
          completer.completeError("No data Found");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AllDevicesProvider.getRetrievedPartsData', [errorMessage]);
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
