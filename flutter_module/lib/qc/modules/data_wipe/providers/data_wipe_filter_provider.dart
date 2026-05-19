import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/filter_title.dart';
import 'package:provider/provider.dart';

class DataWipeFilterProvider extends CshChangeNotifier {
  bool isLoading = true;
  String? screenError;

  Map<String, DataWipeFilterData>? dataWipeFilterMap;
  final List<FilterTitle> _filterTitleList = [];
  Map<String, List<DataWipFilterListItem>>? selectedFilters;

  static DataWipeFilterProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeFilterProvider>(context, listen: listen);
  }

  DataWipeFilterProvider(Map<String, List<DataWipFilterListItem>>? selectedFilter) {
    selectedFilters = selectedFilter;
    _getDataListFilters();
  }

  List<FilterTitle> get filterTitleList => _filterTitleList;

  int getSelectedFilterCount(String filterKey) {
    if (selectedFilters == null || !selectedFilters!.containsKey(filterKey)) {
      return 0;
    }
    return selectedFilters![filterKey]!.length;
  }

  void _createFilterTitleList() {
    _filterTitleList.clear();
    dataWipeFilterMap?.forEach((key, value) {
      _filterTitleList.add(FilterTitle(key, value.filterName!));
    });
  }

  List<DataWipFilterListItem>? getFilterValuesList(String filterKey) {
    return dataWipeFilterMap?[filterKey]?.filterList;
  }

  void _getDataListFilters() {
    DataWipeService.getDataWipeListFilters().listen((event) {
      dataWipeFilterMap = event.dataWipeFilterMap;
      dataWipeFilterMap?.removeWhere((key, value) => key == "qf");
      if (selectedFilters != null) {
        _fillSelectedFilterData();
      }
      _createFilterTitleList();
    }, onError: (error) {
      screenError = ApiErrorHelper.getErrorMessage(error).toString();
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }

  _fillSelectedFilterData() {
    dataWipeFilterMap?.forEach(
      (key, value) {
        if (selectedFilters!.containsKey(key)) {
          value.filterList?.forEach((element) {
            element.isSelected = selectedFilters![key]!.contains(element);
          });
        }
      },
    );
  }

  void onFilterSelected(String key, DataWipFilterListItem filter, bool isSelected) {
    selectedFilters ??= {};
    if (selectedFilters!.containsKey(key)) {
      if (isSelected) {
        selectedFilters![key]!.add(filter);
      } else {
        selectedFilters![key]!.removeWhere((element) => element.id == filter.id);
      }
    } else {
      selectedFilters![key] = [filter];
    }
    notifyListeners();
  }

  void clearAllFilter() {
    selectedFilters = null;
    dataWipeFilterMap?.forEach((key, value) {
      value.filterList?.forEach((element) {
        element.isSelected = false;
      });
    });
    notifyListeners();
  }
}
