import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/searchable.dart';
import '../resources/domain/dispatch_lot_interactor.dart';
import '../resources/domain/dispatch_lot_interactor_impl.dart';
import '../resources/index.dart';
import '../resources/services.dart';

class DispatchLotProvider extends CshChangeNotifier with Searchable {
  late DispatchLotInteractor interactor;
  bool _showSearchBox = false;
  String? _channelQuery;
  late StreamController<String?> controller ;


  DispatchLotProvider() {
    controller = StreamController.broadcast();
    interactor = DispatchLotInteractorImpl();
  }

  Stream<DispatchLotsResponse?> getDataStream(int pageIndex, int pageSize, {String? searchQuery,String? channelQuery}) =>
      interactor.getData(pageIndex, pageSize, searchQuery: searchQuery,channelQuery: channelQuery);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  set channelQuery(String? value) {
    controller.add(value);
    _channelQuery = value;
    notifyListeners();
  }

  String? get channelQuery => _channelQuery ;

  static DispatchLotProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<DispatchLotProvider>(context, listen: listen);
  }

  Future<DispatchCompleteResponse?> initiateDispatchCompletion(String invoiceNumber) {
    var completer = Completer<DispatchCompleteResponse?>();
    DispatchLotServices.completeDispatch(invoiceNumber).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete(event);
      } else {
        completer.completeError(event?.errorMsg ?? "Something Went Wrong");
      }
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
