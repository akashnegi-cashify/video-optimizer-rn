import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class DispatchCompleteProvider extends CshChangeNotifier {
   late TextEditingController textEditingController ;


   DispatchCompleteProvider(){
     textEditingController = TextEditingController();
   }

  static DispatchCompleteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DispatchCompleteProvider>(context, listen: listen);
  }

  Future<DispatchCompleteResponse?> initiateDispatchCompletion() {
    var completer = Completer<DispatchCompleteResponse?>();
    DispatchLotServices.completeDispatch(textEditingController.text).listen((event) {
      completer.complete(event);
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      completer.completeError(errorMsg);
      Logger.debug('DispatchCompleteProvider.initiateDispatchCompletion', [errorMsg]);
    });
    return completer.future;
  }
}
