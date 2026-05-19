import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/box_list_response.dart';
import '../models/shipment_provider_list_response.dart';
import '../resources/create_shipment_service.dart';

class CreateShipmentProvider extends CshChangeNotifier {
  List<BoxListData>? boxList;
  List<ShipmentProviderListData>? providerList;
  bool boxDataLoading = true;
  String? boxDataErrorMessage;
  BoxListData? selectedBox;
  ShipmentProviderListData? selectedProvider;
  bool providerDataListLoading = false;
  bool estimatedProviderDataLoading = false;
  String? providerDataErrorMessage;
  String? pincode, groupId;
  ShipmentProviderListData? estimatedProvider;

  static CreateShipmentProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CreateShipmentProvider>(context, listen: listen);
  }

  CreateShipmentProvider({this.pincode, this.groupId}) {
    _fetchBoxDataList();
  }

  _fetchBoxDataList() {
    CreateShipmentService.getShipmentBoxes().listen((event) {
      if (!Validator.isListNullOrEmpty(event?.boxList)) {
        boxList = event!.boxList;
        selectedBox = event.boxList!.first;
        _fetchProviderListData();
        _fetchEstimatedProvider();
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------CreateShipmentProvider._fetchBoxDataList', [em]);
      boxDataErrorMessage = em;
    }, onDone: () {
      boxDataLoading = false;
      notifyListeners();
    });
  }

  _fetchProviderListData() {
    providerDataListLoading = true;
    notifyListeners();
    CreateShipmentService.getShipmentProviderList(pincode, selectedBox?.id, (groupId != null) ? int.parse(groupId!) : 0)
        .listen((event) {
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
    CreateShipmentService.getExpectedShipmentProvider(selectedBox?.id, (groupId != null) ? int.parse(groupId!) : 0)
        .listen((event) {
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

  onBoxChange(BoxListData data) {
    selectedBox = data;
    selectedProvider = null;
    _fetchProviderListData();
    _fetchEstimatedProvider();
  }

  onProviderChange(ShipmentProviderListData data) {
    selectedProvider = data;
    notifyListeners();
  }

  Future<bool> generateShipment(String facilityId, int groupId) {
    var completer = Completer<bool>();
    try {
      CreateShipmentService.createShipment(facilityId, selectedBox?.id, groupId, selectedProvider?.key ?? "").listen(
          (event) {
        completer.complete(true);
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------CreateShipmentProvider.generateShipment', [em]);
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
