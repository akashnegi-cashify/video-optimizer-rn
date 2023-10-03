import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class DispatchFilterProvider extends CshChangeNotifier {
  late ListState<FilterItem?> _filters;

  DispatchFilterProvider() {
    _filters = ListState();
    fetchFilter();
  }

  static DispatchFilterProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<DispatchFilterProvider>(context, listen: listen);
  }

  void fetchFilter() {
    DispatchLotServices.dispatchFilters().listen((event) {
      _filters = _filters.copyWith(status: RequestStatus.success, data: event?.data);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      _filters = _filters.copyWith(status: RequestStatus.failure, data: null, errorMsg: errorMsg);
      notifyListeners();
      Logger.debug('DispatchFilterProvider.dispatchFilters', [errorMsg]);
    });
  }

  void updateFilterSelectionState(String? key) {
    var items = ArrayUtil.removeNullItems<FilterItem?>(_filters.data ?? []);
    var item = ArrayUtil.firstWhereNull<FilterItem>(items,(element) => element?.channelKey?.toLowerCase() == key?.toLowerCase(),);
    if (item != null) {
      item.isSelected = !item.isSelected;
    }
  }

  void clearFilter(){
    _filters.data?.forEach((element) => element?.isSelected = false);
    notifyListeners();
  }

  String? getSelectedFilter() {
    return ArrayUtil.firstWhereNull<FilterItem?>(
        ArrayUtil.removeNullItems(_filters.data ?? []), (element) => element?.isSelected == true)?.channelKey;
  }

  List<FilterItem?>? get filters => _filters.data;

  RequestStatus get status => _filters.status;
}
