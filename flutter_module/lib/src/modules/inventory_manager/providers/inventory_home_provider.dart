import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/inventory_location_response.dart';
import '../models/rider_list_response.dart';
import '../resources/inventory_manager_service.dart';

class InventoryHomeProvider extends CshChangeNotifier {
  static InventoryHomeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<InventoryHomeProvider>(context, listen: listen);
  }

  InventoryHomeProvider() {
    _getInventoryLocations();
  }

  bool isDataLoading = true, allowPendingWidget = false;
  List<GroupLocationModel> listOfGroupLocation = [];
  InventoryLocationResponse? inventoryLocationResponse;
  String? barcode;
  String? engineerName;
  List<int> selectedDeviceIdList = [];
  String? errorMessage;
  RiderListResponse? riderListResponse;
  RiderListDataResponse? selectedRider;

  _getInventoryLocations() {
    InventoryService.getInventoryLocation().listen((event) {
      if (event != null) {
        inventoryLocationResponse = event;
        if (!Validator.isListNullOrEmpty(event.locationsDataList)) {
          _getGroupLocationList(event.locationsDataList!);
        }
        isDataLoading = false;
        notifyListeners();
      }
    }, onError: (error) {
      String apiErrorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
      Logger.debug('mydebug------InventoryHomeProvider._getInventoryLocations', [apiErrorMessage]);
      errorMessage = apiErrorMessage;
      isDataLoading = false;
      notifyListeners();
    });
  }

  void updateAssignedTabListData(bool checked, int deviceId) {
    if (checked) {
      selectedDeviceIdList.add(deviceId);
    } else {
      selectedDeviceIdList.remove(deviceId);
    }
    notifyListeners();
  }

  Future<bool> getListOfRiders() {
    selectedRider = null;
    var completer = Completer<bool>();
    try {
      InventoryService.geListOfRider("").listen((event) {
        if (event != null) {
          completer.complete(true);
          riderListResponse = event;
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------InventoryHomeProvider.getListOfRiders', [errMessage]);
        completer.completeError(errMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> assignRider() {
    var completer = Completer<bool>();
    try {
      int? riderIdInt = selectedRider?.riderId != null ? int.tryParse(selectedRider!.riderId!) : null;
      InventoryService.assignRider(selectedDeviceIdList, riderIdInt ?? -1).listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------InventoryHomeProvider.assignRider', [errMessage]);
        completer.completeError(errMessage);
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  String? getLocationsString() {
    List<String> locationList = [];
    if (!Validator.isListNullOrEmpty(listOfGroupLocation)) {
      for (var element in listOfGroupLocation) {
        if (element.isSelected == true) {
          locationList.add(element.locationName ?? "");
        }
      }
      return locationList.join(",");
    }
    return "";
  }

  _getGroupLocationList(List<String> locationList) {
    listOfGroupLocation = locationList.map((e) {
      return GroupLocationModel(
        locationName: e,
        isSelected: false,
      );
    }).toList();
  }

  toggleLocationState(String locationName, bool status) {
    if (!Validator.isListNullOrEmpty(listOfGroupLocation)) {
      int index = listOfGroupLocation.indexWhere((element) => element.locationName == locationName);
      if (index != -1) {
        listOfGroupLocation[index].isSelected = status;
      }
    }
  }

  allowPendingListToShow(bool value) {
    allowPendingWidget = value;
    notifyListeners();
  }

  bool checkForLocationSelected() {
    if (!Validator.isListNullOrEmpty(listOfGroupLocation)) {
      for (var element in listOfGroupLocation) {
        if (element.isSelected == true) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkIfAssignedForRider() {
    return selectedDeviceIdList.isNotEmpty;
  }

  List<RiderListDataResponse> getSearchResults({String? pattern}) {
    if (Validator.isNullOrEmpty(pattern)) {
      return (!Validator.isListNullOrEmpty(riderListResponse?.riderDataList)) ? riderListResponse!.riderDataList! : [];
    } else {
      List<RiderListDataResponse> searchingList = [];
      if (!Validator.isListNullOrEmpty(riderListResponse?.riderDataList)) {
        searchingList = riderListResponse!.riderDataList!.where((element) {
          if ((!Validator.isNullOrEmpty(element.riderName)) &&
              element.riderName!.toLowerCase().contains(pattern!.toLowerCase())) {
            return true;
          } else {
            return false;
          }
        }).toList();
      }

      return searchingList;
    }
  }
}
