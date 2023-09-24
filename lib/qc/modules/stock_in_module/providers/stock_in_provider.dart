import 'dart:async';
import 'package:collection/collection.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/accessories_option_data.dart';
import '../models/stock_in_submit_response.dart';
import '../models/stock_in_submit_request.dart';
import '../models/validate_awb_response.dart';
import '../resources/stock_in_service.dart';
import '../types.dart';


class StockInProvider extends CshChangeNotifier {
  final ValidateAwbResponse? stockInProductDetail;
  List<AccessoriesOptionData> accessoriesOptionDataList = [];
  bool _isAuditStatusFailSelected = false;

  StockInProvider(this.stockInProductDetail);

  static StockInProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StockInProvider>(context, listen: listen);
  }

  void updateItemSelectionStatus(int grpIndex, int itemIndex) {
    var group = stockInProductDetail?.groups?[grpIndex];
    var item = stockInProductDetail?.groups?[grpIndex]?.items?[itemIndex];
    if (item == null) return;
    item.isChecked = item.isChecked != null ? !item.isChecked! : false;

    if (group?.label?.toLowerCase() == StockInConstants.AUDIT_STATUS) {
      isAuditStatusFailSelected = !isAuditStatusFailSelected;
    } else {
      notifyListeners();
    }
  }

  bool getItemSelectionStatus(int grpIndex, int itemIndex) {
    var item = stockInProductDetail?.groups?[grpIndex]?.items?[itemIndex];
    if (item == null) return false;
    return item.isChecked ?? false;
  }

  bool get isAuditStatusFailSelected => _isAuditStatusFailSelected;

  set isAuditStatusFailSelected(bool value) {
    _isAuditStatusFailSelected = value;
    notifyListeners();
  }

  Future<StockInSubmitResponse> stockInSubmission(StockInSubmitRequest request) {
    Completer<StockInSubmitResponse> completer = Completer();
    StockInService.pushAwb(request).listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  bool isAccessoriesOptionSelected() {
    return accessoriesOptionDataList.every((element) {
      return element.availableFlag != null;
    });
  }

  void createAccessoriesOptionListData() {
    accessoriesOptionDataList.clear();
    accessoriesOptionDataList = [
      AccessoriesOptionData(optionName: 'Box'),
      AccessoriesOptionData(optionName: 'Charger'),
    ];
  }

  Map<String, Items> filterUploadMediaFileItems() {
    Map<String, Items> items = {};
    stockInProductDetail?.groups?.forEachIndexed((grpIndex,grp) {
      grp?.items?.forEachIndexed((index,item) {
        if(item?.isChecked == true && ((item?.imageCount ?? 0) > 0 || (item?.videoCount ?? 0) > 0)){
          var key = item?.label ?? grp.label ?? 'grp_${grpIndex}_item_$index';
          item?.resetList();
          items[key] = item!;
        }
      });
    });

    return items;
  }

  List<SelectionData> convertMapToSelectionData(Map<String, Items> data){
    List<SelectionData> result = [];
    stockInProductDetail?.groups?.forEachIndexed((grpIndex,grp) {
      var selectionData = SelectionData();
      grp?.items?.forEachIndexed((index,item) {
        if(item?.isChecked == true && ((item?.imageCount ?? 0) > 0 || (item?.videoCount ?? 0) > 0)){
          selectionData.key = item?.key;
          selectionData.imgList = item?.imageUrls;
          selectionData.videoList = item?.videoUrls;
          selectionData.value = 1;
          selectionData.groupLabel =grp.label ;

          result.add(selectionData);
        }
      });

    });

    return result;
  }
}
