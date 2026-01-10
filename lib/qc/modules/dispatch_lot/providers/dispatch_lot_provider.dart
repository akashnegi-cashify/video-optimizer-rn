import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/searchable.dart';
import '../resources/index.dart';
import '../resources/services.dart';

class DispatchLotProvider extends CshChangeNotifier with Searchable {
  bool _showSearchBox = false;
  List<int>? _lotType;
  late StreamController<List<int>?> controller;

  DispatchLotProvider() {
    controller = StreamController.broadcast();
  }

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  set lotType(List<int>? value) {
    controller.add(value);
    _lotType = value;
    notifyListeners();
  }

  List<int>? get lotType => _lotType;

  static DispatchLotProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<DispatchLotProvider>(context, listen: listen);
  }

  Future<void> initiateDispatchCompletion(String invoiceNumber) {
    var completer = Completer<DispatchCompleteResponse?>();
    DispatchLotServices.completeDispatch(invoiceNumber).listen((event) {
      completer.complete();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      completer.completeError(errorMsg);
      Logger.debug('DispatchCompleteProvider.initiateDispatchCompletion', [errorMsg]);
    });
    return completer.future;
  }

  bool get showSearchBox => _showSearchBox;

  set showSearchBox(bool value) {
    _showSearchBox = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }
}
