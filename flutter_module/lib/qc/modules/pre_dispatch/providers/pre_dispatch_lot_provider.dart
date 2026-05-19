import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class PreDispatchLotProvider extends CshChangeNotifier {
  List<int>? _lotTypeQuery;
  late StreamController<List<int>?> controller;
  String? _lotName;
  String? _barcode;

  set barcode(String value) {
    _barcode = value;
  }

  set lotName(String? value) {
    _lotName = value;
  }

  PreDispatchLotProvider() {
    controller = StreamController.broadcast();
  }

  set lotTypeQuery(List<int>? value) {
    controller.add(value);
    _lotTypeQuery = value;
  }

  List<int>? get lotTypeQuery => _lotTypeQuery;

  static PreDispatchLotProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<PreDispatchLotProvider>(context, listen: listen);
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  Future<CompletePreDispatchResponse?> completePreDispatchLot(String groupLotName) {
    var completer = Completer<CompletePreDispatchResponse?>();
    DispatchLotServices.completePreLotDispatch(groupLotName).listen((event) {
      completer.complete(event);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      completer.completeError(errorMsg);
      Logger.debug('PreDispatchProvider.scanPreDispatchLot', [errorMsg]);
      notifyListeners();
    });
    return completer.future;
  }

  void resetSearchFilters() {
    _lotName = null;
    _barcode = null;
  }
}
