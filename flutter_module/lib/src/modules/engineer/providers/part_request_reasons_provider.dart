import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:flutter_trc/src/modules/engineer/models/reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class PartRequestReasonsProvider extends CshChangeNotifier {
  List<OrderEngineerPart> partRequestList = [];

  Map<String, List<ReasonListData>>? _categoryReasonsMap;
  String? reasonListError;
  bool isPageLoading = true;

  PartRequestReasonInterface? partRequestReasonInterface;

  List<String>? _categoryCodeList;

  static PartRequestReasonsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartRequestReasonsProvider>(context, listen: listen);
  }

  PartRequestReasonsProvider(this.partRequestList) {
    Future.wait([_getReasonList(), _getCategoryCodeList()]).catchError((error) {
      reasonListError = error.toString();
      return <dynamic>[];
    }).whenComplete(
      () {
        isPageLoading = false;
        bool isReasonNeeded = false;
        if (Validator.isNullOrEmpty(reasonListError)) {
          for (var item in partRequestList) {
            if (isReasonRequired(item)) {
              isReasonNeeded = true;
              break;
            }
          }
          if (!isReasonNeeded) {
            partRequestReasonInterface?.noReasonRequired(partRequestList);
          }
        }

        notifyListeners();
      },
    );
  }

  Future<void> _getCategoryCodeList() {
    var completer = Completer<void>();
    EngineerAPIService.getCategoryCodeList().listen((event) {
      _categoryCodeList = event?.categoryCodeList;
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<void> _getReasonList() {
    var completer = Completer<void>();
    EngineerAPIService.getPartRequestReasonList().listen((event) {
      _categoryReasonsMap = event?.reasonsMap;
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isReasonRequired(OrderEngineerPart item) {
    return ElssPartsSelectionOptions.getEnumById(item.partType) == ElssPartsSelectionOptions.repairRequired &&
        _categoryCodeList?.contains(item.categoryCode) == true;
  }

  void updatePartRequestItem(OrderEngineerPart item) {
    int index = partRequestList.indexWhere((element) => element.sku == item.sku && element.partColor == item.partColor);
    partRequestList[index] = item;
    notifyListeners();
  }

  bool isAllReasonsSelected() {
    for (var item in partRequestList) {
      if (!isReasonRequired(item)) {
        continue;
      }

      /// If reasons is not selected
      if (item.reasonId == null) {
        return false;
      }
      var reasonsList = _categoryReasonsMap?[item.categoryCode];
      bool isImageRequired =
          reasonsList?.firstWhere((element) => element.reasonId == item.reasonId).isImageRequired ?? false;

      /// If reasons is selected but image is required and not uploaded
      if (isImageRequired && Validator.isListNullOrEmpty(item.imageList)) {
        return false;
      }

      /// If reasons is selected but image is empty
      if (isImageRequired && Validator.isNullOrEmpty(item.imageList?.first)) {
        return false;
      }
    }
    return true;
  }

  List<OrderEngineerPart> filterRequestedPartList() {
    for (var element in partRequestList) {
      var index = element.imageList?.indexWhere((element) => Validator.isNullOrEmpty(element));
      if (index != null && index > -1) {
        element.imageList?.removeAt(index);
      }
    }
    return partRequestList;
  }

  List<DropDownItem<ReasonListData>>? getReasonsAccToCategoryCode(String categoryCode) {
    if (_categoryReasonsMap == null) {
      return [];
    }

    var reasonList = _categoryReasonsMap?[categoryCode];
    return reasonList?.map((e) => DropDownItem<ReasonListData>(e.reasonId.toString(), e.reason ?? "", extraData: e)).toList();
  }
}

abstract interface class PartRequestReasonInterface {
  void noReasonRequired(List<OrderEngineerPart> partList);
}
