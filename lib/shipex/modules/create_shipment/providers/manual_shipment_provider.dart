import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shipment_provider_list_response.dart';
import '../resources/create_shipment_service.dart';

class ManualShipmentProvider extends CshChangeNotifier {
  bool providerDataListLoading = true;
  String? providerDataErrorMessage;
  bool estimatedProviderDataLoading = false;
  ShipmentProviderListData? selectedProvider;
  ShipmentProviderListData? estimatedProvider;
  List<ShipmentProviderListData>? providerList;
  String? pincode;
  int? boxId, groupId, facilityId, shipmentId;

  static ManualShipmentProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ManualShipmentProvider>(context, listen: listen);
  }

  ManualShipmentProvider({this.groupId, this.pincode, this.boxId, this.facilityId, this.shipmentId}) {
    _fetchEstimatedProvider();
    _fetchProviderListData();
  }

  _fetchProviderListData() {
    providerDataListLoading = true;
    notifyListeners();
    CreateShipmentService.getShipmentProviderList(pincode, boxId, (groupId != null) ? groupId! : 0).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.providerList)) {
        providerList = event!.providerList!;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------CreateShipmentProvider.fetchProviderListData', [em]);
      providerDataErrorMessage = em;
    }, onDone: () {
      providerDataListLoading = false;
      notifyListeners();
    });
  }

  _fetchEstimatedProvider() {
    estimatedProviderDataLoading = true;
    notifyListeners();
    CreateShipmentService.getExpectedShipmentProvider(boxId, (groupId != null) ? groupId! : 0).listen((event) {
      if (event != null) {
        estimatedProvider = event.expectedProvider;
        selectedProvider = event.expectedProvider;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------CreateShipmentProvider._fetchEstimatedProvider', [em]);
    }, onDone: () {
      estimatedProviderDataLoading = false;
      notifyListeners();
    });
  }

  onProviderChange(ShipmentProviderListData data) {
    selectedProvider = data;
    notifyListeners();
  }

  Future<bool> createManualShipment({required String awbNumber, required String docUrl}) {
    var completer = Completer<bool>();
    try {
      CreateShipmentService.createManualShipment((facilityId != null) ? facilityId.toString() : "", boxId, groupId,
              selectedProvider?.key ?? "", docUrl, awbNumber)
          .listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.completeError('something went wrong');
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> updateManualShipment({required String awbNumber, required String docUrl}) {
    var completer = Completer<bool>();
    try {
      CreateShipmentService.updateManualShipment(
        facilityId: (facilityId != null) ? facilityId.toString() : "",
        selectedProviderKey: selectedProvider?.key ?? "",
        shipmentId: shipmentId,
        awbNumber: awbNumber,
        awbUrl: docUrl,
      ).listen((event) {
        completer.complete(true);
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
