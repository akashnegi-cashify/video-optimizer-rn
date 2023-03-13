import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/inventory_location_response.dart';
import '../resources/inventory_manager_service.dart';

class InventoryHomeProvider extends CshChangeNotifier {
  static InventoryHomeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<InventoryHomeProvider>(context, listen: listen);
  }

  List<String> selectedLocation = [];

  InventoryHomeProvider() {
    _getInventoryLocations();
  }

  bool isDataLoading = true;
  InventoryLocationResponse? inventoryLocationResponse;
  String? errorMessage;

  _getInventoryLocations() {
    InventoryService.getInvetoryLocation().listen((event) {
      if (event != null) {
        inventoryLocationResponse = event;
      }
    }, onError: (error) {
      String apiErrorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
      Logger.debug('mydebug------InventoryHomeProvider._getInventoryLocations', [apiErrorMessage]);
      errorMessage = apiErrorMessage;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }
}
