import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class VariantListProvider extends CalculatorServiceInitProvider with Searchable {
  static VariantListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<VariantListProvider>(context, listen: listen);
  }

  final int productId;
  final String seriesName;

  bool isShowLoading = true;
  List<VariantListData>? _variantList;

  VariantListProvider(this.productId, this.seriesName);

  List<VariantListData>? get variantList => Validator.isNullOrEmpty(searchQuery)
      ? _variantList
      : _variantList
          ?.where((element) =>
              (element.name?.toLowerCase().contains(searchQuery!.toLowerCase()) ?? false) ||
              (element.commonName?.toLowerCase().contains(searchQuery!.toLowerCase()) ?? false))
          .toList();

  void setSearchQuery(String? value) {
    searchQuery = value;
    notifyListeners();
  }

  void getVariantList() {
    service.getVariantList(productId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.variantListResponseData)) {
        _variantList = event?.variantListResponseData;
      }
    }, onError: (error) {
      isShowLoading = false;
      notifyListeners();
    }, onDone: () {
      isShowLoading = false;
      notifyListeners();
    });
  }
}
