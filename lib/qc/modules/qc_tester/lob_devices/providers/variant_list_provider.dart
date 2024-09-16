import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/service_initialize_interface.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class VariantListProvider extends CalculatorServiceInitProvider with Searchable {
  static VariantListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<VariantListProvider>(context, listen: listen);
  }

  bool isPageInitializing = true;

  ServiceInitializeInterface? initializedInterface;

  final int productId;

  VariantListProvider(this.productId);

  @override
  void onServiceInitialized() {
    isPageInitializing = false;
    initializedInterface?.initialize();
  }

  void setServiceInitializedListener(ServiceInitializeInterface interface) {
    initializedInterface = interface;
  }

  Future<List<VariantListData>> getVariantList({required int pageSize, required int pageNo}) {
    var completer = Completer<List<VariantListData>>();
    service.getVariantList(productId, pageNo: pageNo, pageSize: pageSize, searchQuery: searchQuery).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.variantListResponseData)) {
        completer.complete(event?.variantListResponseData);
      } else {
        completer.completeError("No variant found for this product");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
