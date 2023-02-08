import 'dart:ui';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

import '../models/order_engineer_part.dart';

class OrderPartProvider extends CshChangeNotifier {
  final String? deviceBarcode;

  String? _query;

  String? get query => _query;

  set query(String? value) {
    _query = value;
    notifyListeners();
  }

  List<OrderEngineerPart> get displayList => _originalDataList
      .where((element) => (element.partName.containsIgnoreCase(query) || element.sku.containsIgnoreCase(query)))
      .toList();

  List<OrderEngineerPart> _originalDataList = [];

  OrderPartProvider(this.deviceBarcode);

  getListParts(Function(String errorMessage) handleError, L10n l10n) {
    _originalDataList = [];

    EngineerAPIService.listDeviceParts(deviceBarcode).listen((event) {
      _originalDataList = event?.partDataList ?? [];

      if (event?.errorMsg != null) {
        handleError(event!.errorMsg!);
      }
    }, onError: (e, s) {
      handleError(ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong);
    }, onDone: () {
      notifyListeners();
    });
  }

  updateDataForNIndex(int n, int update) {
    _originalDataList[n].orderQuantity = (_originalDataList[n].orderQuantity ?? 0) + update;
    notifyListeners();
  }

  orderParts(Function(String errorMessage) handleError, L10n l10n, VoidCallback callback) {
    EngineerAPIService.orderDeviceParts(
            deviceBarcode, displayList.where((element) => (element.orderQuantity ?? 0) > 0).toList())
        .listen((event) {
      if (event?.isSuccess == true) {
        callback();
      } else {
        handleError(event?.errorMsg ?? l10n.somethingWentWrong);
      }
    }, onError: (error, stacktrace) {
      handleError(ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
    }, onDone: () {
      getListParts((errorMessage) => handleError, l10n);
    });
  }
}

extension StringOps on String? {
  bool containsIgnoreCase(String? query) {
    return (this ?? "").toLowerCase().contains(query?.toLowerCase() ?? "");
  }
}
