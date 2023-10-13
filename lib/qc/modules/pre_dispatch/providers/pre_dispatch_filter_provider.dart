import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';
import '../resources/services.dart';

class PreDispatchFilterProvider extends CshChangeNotifier {
  late ListState<PreDispatchFilterItem?> _filters;

  PreDispatchFilterProvider() {
    _filters = ListState();
    fetchFilter();
  }

  static PreDispatchFilterProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<PreDispatchFilterProvider>(context, listen: listen);
  }

  void fetchFilter() {
    DispatchLotServices.preDispatchFilters().listen((event) {
      _filters = _filters.copyWith(status: RequestStatus.success, data: event?.data);
      notifyListeners();
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      _filters = _filters.copyWith(status: RequestStatus.failure, data: null, errorMsg: errorMsg);
      notifyListeners();
      Logger.debug('PreDispatchFilterProvider.dispatchFilters', [errorMsg]);
    });
  }

  void updateFilterSelectionState(String? lotType) {
    var items = ArrayUtil.removeNullItems<PreDispatchFilterItem?>(_filters.data ?? []);
    var item = ArrayUtil.firstWhereNull<PreDispatchFilterItem>(items,(element) => element?.lotType?.toLowerCase() == lotType?.toLowerCase(),);
    if (item != null) {
      item.isSelected = !item.isSelected;
    }
  }

  void clearFilter(){
    _filters.data?.forEach((element) => element?.isSelected = false);
    notifyListeners();
  }

  String? getSelectedFilter() {
    return ArrayUtil.firstWhereNull<PreDispatchFilterItem?>(
        ArrayUtil.removeNullItems(_filters.data ?? []), (element) => element?.isSelected == true)?.lotType;
  }

  List<PreDispatchFilterItem?>? get filters => _filters.data;

  RequestStatus get status => _filters.status;
}
