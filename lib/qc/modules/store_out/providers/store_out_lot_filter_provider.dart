import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/resources/lot_type_filter_response.dart';
import '../resources/services.dart';

class StoreOutLotFilterProvider extends CshChangeNotifier {
  late ListState<LotTypeFilterItem?> _filters;

  StoreOutLotFilterProvider() {
    _filters = ListState();
    _fetchFilter();
  }

  static StoreOutLotFilterProvider of({required BuildContext context, bool listen = true}) {
    return Provider.of<StoreOutLotFilterProvider>(context, listen: listen);
  }

  void _fetchFilter() {
    StoreOutServices.storeOutLotTypeFilters().listen((event) {
      _filters = _filters.copyWith(status: RequestStatus.success, data: event?.data);
    }, onError: (error, stack) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      _filters = _filters.copyWith(status: RequestStatus.failure, data: null, errorMsg: errorMsg);
      Logger.debug('StoreOutLotFilterProvider.dispatchFilters', [errorMsg]);
    }, onDone: () {
      notifyListeners();
    });
  }

  void updateFilterSelectionState(String? lotType) {
    var items = ArrayUtil.removeNullItems<LotTypeFilterItem?>(_filters.data ?? []);
    var item = ArrayUtil.firstWhereNull<LotTypeFilterItem>(items,(element) => element?.lotType?.toLowerCase() == lotType?.toLowerCase(),);
    if (item != null) {
      item.isSelected = !item.isSelected;
    }
  }

  void clearFilter(){
    _filters.data?.forEach((element) => element?.isSelected = false);
    notifyListeners();
  }

  String? getSelectedFilter() {
    return ArrayUtil.firstWhereNull<LotTypeFilterItem?>(
        ArrayUtil.removeNullItems(_filters.data ?? []), (element) => element?.isSelected == true)?.lotType;
  }

  List<LotTypeFilterItem?>? get filters => _filters.data;

  RequestStatus get status => _filters.status;
}
