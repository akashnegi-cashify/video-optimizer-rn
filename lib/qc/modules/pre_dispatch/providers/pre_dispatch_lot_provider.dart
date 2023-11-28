import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/searchable.dart';
import '../resources/index.dart';
import '../resources/services.dart';

class PreDispatchLotProvider extends CshChangeNotifier with Searchable {
  bool _showSearchBox = false;
  List<String>? _lotTypeQuery;
  late StreamController<List<String>?> controller ;


  PreDispatchLotProvider() {
    controller = StreamController.broadcast();
  }

  Stream<PreDispatchLotsResponse?> getDataStream(PreDispatchLotRequest request){
    return DispatchLotServices.getPreDispatchListData(request);
  }

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  set lotTypeQuery(List<String>? value) {
    controller.add(value);
    _lotTypeQuery = value;
  }

  List<String>? get lotTypeQuery => _lotTypeQuery ;

  static PreDispatchLotProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<PreDispatchLotProvider>(context, listen: listen);
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


}
