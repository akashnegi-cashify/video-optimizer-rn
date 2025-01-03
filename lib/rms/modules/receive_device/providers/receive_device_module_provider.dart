import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/receive_device_service.dart';
import 'package:provider/provider.dart';

import '../resources/accessories_data.dart';

class ReceiveDeviceModuleProvider extends CshChangeNotifier {
  static ReceiveDeviceModuleProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReceiveDeviceModuleProvider>(context, listen: listen);
  }

  List<AccessoriesData> transformData(Map<String, String> accessoriesMap) {
    List<AccessoriesData> accessoriesList = [];
    accessoriesMap.forEach((key, value) {
      accessoriesList.add(AccessoriesData(key, value));
    });
    return accessoriesList;
  }

  Future<List<AccessoriesData>> getDeviceDetails(String barcode, BarcodeTypes barcodeType) {
    var completer = Completer<List<AccessoriesData>>();
    try{
      ReceiveDeviceService.getDeviceDetails(barcode, barcodeType, isForce: true).listen((event) {
        if (event?.accessoriesMap == null) {
          completer.complete([]);
        } else {
          completer.complete(transformData(event!.accessoriesMap!));
        }
      }, onError: (error) {
        String? errorMessage = ApiErrorHelper.getErrorMessage(error);
        completer.completeError(errorMessage.toString());
      });
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }

  Future<String> receiveDevice(
      String barcode, BarcodeTypes barcodeType, int facilityId, List<AccessoriesData>? accessoriesList,
      {List<String>? accessoryList}) {
    var completer = Completer<String>();
    Map<String, String>? accessoriesMap;
    if (!Validator.isListNullOrEmpty(accessoriesList)) {
      accessoriesMap = {};
      accessoriesList?.forEach((element) {
        accessoriesMap![element.name] = element.value;
      },);
    }

    ReceiveDeviceService.receiveDevice(barcode, facilityId, barcodeType, accessoriesMap).listen((event) {
      completer.complete(event?.successMessage ?? "Device received successfully");
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }
}
