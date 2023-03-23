import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/engineer_list_response.dart';
import '../models/inventory_location_response.dart';
import '../models/pending_device_list_response.dart';
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
  int offsetLength = 10;
  String barcode = "";
  bool isUrgent = false;
  List<PendingDeviceDetailData> assignedTabListData = [];
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

  Future<EngineerListResponse?> getAssignmentPendingEngineerList(int pageNumber) {
    var completer = Completer<EngineerListResponse?>();
    try {
      InventoryService.getAssignmentPendingEngineerList(getLocationsString() ?? "", pageNumber, offsetLength).listen(
          (event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(event);
        } else {
          completer.completeError("Something went wrong!!");
        }
      }, onError: (error) {
        String apiErrorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
        Logger.debug('mydebug------InventoryHomeProvider.getAssignmentPendingEngineerList', [apiErrorMessage]);
        completer.completeError(apiErrorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<PendingDeviceListResponse> getListOfAssignmentPendingDevices(int pageNo) {
    var completer = Completer<PendingDeviceListResponse>();
    try {
      InventoryService.getListOfAssignmentPendingDevices(pageNo, offsetLength, isUrgent: isUrgent, barcode: barcode)
          .listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(event);
          if (!Validator.isListNullOrEmpty(event.data?.dataList)) {
            assignedTabListData.addAll(event.data!.dataList!);
          }
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------InventoryHomeProvider.getListOfAssignmentPendingDevices', [errMessage]);
        completer.completeError(errMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> getListOfRiders() {
    selectedRider = null;
    var completer = Completer<bool>();
    try {
      InventoryService.geListOfRider("").listen((event) {
        if (event != null && event.isSuccess == true) {
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
      InventoryService.assignRider(getListIfAssignedRiderDId(), selectedRider?.riderId ?? -1).listen((event) {
        if (event != null && event.isSuccess == true) {
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

  resetDataList() {
    assignedTabListData.clear();
    notifyListeners();
  }

  checkIfAssignedForRider() {
    if (assignedTabListData.isNotEmpty) {
      for (var element in assignedTabListData) {
        if (element.isAssignedToRider == true) {
          return true;
        }
      }
    }
    return false;
  }

  List<int> getListIfAssignedRiderDId() {
    List<int> dataList = [];
    if (assignedTabListData.isNotEmpty) {
      for (var element in assignedTabListData) {
        if (element.isAssignedToRider == true) {
          dataList.add(element.did ?? -1);
        }
      }
    }
    return dataList;
  }

  List<RiderListDataResponse> getSearchResults({String? pattern}) {
    if (Validator.isNullOrEmpty(pattern)) {
      return (!Validator.isListNullOrEmpty(riderListResponse?.riderDataList)) ? riderListResponse!.riderDataList! : [];
    } else {
      List<RiderListDataResponse> searchingList = [];
      if (!Validator.isListNullOrEmpty(riderListResponse?.riderDataList)) {
        searchingList = riderListResponse!.riderDataList!.where((element) {
          if (element.riderName?.toLowerCase() == pattern!.toLowerCase()) {
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
