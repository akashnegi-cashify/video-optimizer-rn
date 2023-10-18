import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/services.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';

class StoreInProvider extends CshChangeNotifier {
  final String? locBarcode;
  int? availableSpace;
  int? totalCount;
  final bool isBinStoreIn;

  static StoreInProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreInProvider>(context, listen: listen);
  }

  StoreInProvider({this.locBarcode, this.availableSpace, this.totalCount,required this.isBinStoreIn,});

  Future<StoreInLocationVerifyResponse?> storeInDevice(
    String deviceBarCode,
  ) {
    var completer = Completer<StoreInLocationVerifyResponse?>();
    StoreInServices.storeInDevice(StoreInDeviceRequest(stockBarcode: deviceBarCode, locBarcode: locBarcode),isBinStoreIn).listen(
        (event) {

          if(event?.isValid()==true){
            totalCount = event?.totalSpace;
            availableSpace = event?.availableSpace;

            completer.complete(event);
          }
          else{
            completer.completeError('Error In Location Tagged To Device.');
          }


      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('StoreInProvider.storeInDevice', [errorMsg]);
      completer.completeError(errorMsg);
      notifyListeners();
    });

    return completer.future;
  }
}
