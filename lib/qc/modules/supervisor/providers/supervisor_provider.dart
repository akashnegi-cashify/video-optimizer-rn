import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_base_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_service.dart';
import 'package:provider/provider.dart';

final class SupervisorProvider extends SupervisorBaseProvider {
  Map<String, CategoryCounter> categoryCounterMap = {};
  SupervisorDeviceDetailResponse? res;
  final String deviceBarcode;

  bool isLoading = true;
  String? errorMessage;

  static SupervisorProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SupervisorProvider>(context, listen: listen);
  }

  SupervisorProvider(this.deviceBarcode) {
    _getDeviceDetails(deviceBarcode);
  }

  _getDeviceDetails(String? deviceBarcode) {
    SupervisorService.getDeviceDetails(deviceBarcode, isFullResponse: true).listen((event) {
      errorMessage = null;
      res = event;
      partVariationList = event?.partVariationListResponse;
      partVariationList?.sort((a, b) => a.category!.compareTo(b.category!));
      _createCategoryGrouping();
    }, onError: (error) {
      errorMessage = ApiErrorHelper.getErrorMessage(error);
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }

  void _createCategoryGrouping() {
    categoryCounterMap.clear();
    for (var i = 0; i < partVariationList!.length; i++) {
      var item = partVariationList![i];
      if (categoryCounterMap.containsKey(item.category)) {
        var counter = categoryCounterMap[item.category];
        if (counter != null) {
          counter.endCounter = i;
        }
      } else {
        categoryCounterMap[item.category!] = CategoryCounter(i, i);
      }
    }
  }

  List<PartVariationData>? getCategoryVisePartVariationList(String category) {
    var counter = categoryCounterMap[category]!;
    return partVariationList?.sublist(counter.startCounter, (counter.endCounter! + 1));
  }

  List<String> getCategoryList() {
    return categoryCounterMap.keys.toList();
  }

  (double, String) getProgressValue(String category) {
    var list = getCategoryVisePartVariationList(category);
    var total = list!.length;
    int selectedValues = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i].userSelectedVariantId != null) {
        selectedValues++;
      }
    }
    return (selectedValues / total, "$selectedValues / $total");
  }

  List<List<ImageData>>? getGalleryImages() {
    if (Validator.isListNullOrEmpty(res?.deviceMediaListResponse)) {
      return null;
    }
    List<List<ImageData>>? list = [];
    for (var i = 0; i < res!.deviceMediaListResponse!.length; i++) {
      var item = res!.deviceMediaListResponse![i];
      if (item.path != null) {
        list.add([ImageData(i, item.path!)]);
      }
    }
    return list;
  }

  Future<void> submitDeviceDetails(String? remarks) {
    var completer = Completer<void>();
    SupervisorService.submitDeviceData(deviceBarcode, _getMismatchedData(), remarks: remarks).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Map<String, dynamic> _getMismatchedData() {
    Map<String, dynamic> mismatchedData = {};
    for (var i = 0; i < partVariationList!.length; i++) {
      var item = partVariationList![i];
      if (item.userSelectedVariantId != null) {
        mismatchedData[item.partId!.toString()] = {
          "vi": item.userSelectedVariantId,
          if (item.imageUrl != null) "iurl": item.imageUrl
        };
      }
    }
    return mismatchedData;
  }

  bool isAnyQuestionAnswered() {
    for (var i = 0; i < partVariationList!.length; i++) {
      var item = partVariationList![i];
      if (item.userSelectedVariantId != null) {
        return true;
      }
    }
    return false;
  }
}

class CategoryCounter {
  final int startCounter;
  int? endCounter;

  CategoryCounter(this.startCounter, this.endCounter);
}
