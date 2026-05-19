import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/qc_repost_response.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/base_part_qc_retrieved_part_provider.dart';
import 'package:provider/provider.dart';

class PartQcUserReportProvider extends BasePartQcRetrievedPartProvider {
  static PartQcUserReportProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartQcUserReportProvider>(context, listen: listen);
  }

  List<String> queries = [];
  DateTimeRange? dateTimeRange;

  onQueryChange(String query, bool state) {
    if (state == false) {
      queries.remove(query);
    } else {
      queries.add(query);
    }
    notifyListeners();
  }

  onDateTimeChange(DateTimeRange range) {
    dateTimeRange = range;
    fetchQcReportData();
  }

  List<QcRepostCategoryResponseList?> getSearchResults(List<QcRepostCategoryResponseList?> masterData) {
    if (queries.isEmpty) {
      return qcReportData.data!;
    } else {
      return qcReportData.data!.where((element) => queries.contains(element?.categoryCode ?? "")).toList();
    }
  }

  @override
  Map<String, dynamic>? getFilterData() {
    Map<String, dynamic>? filterData = {"fp": {}}; // as a identifier for user specific report or dashboard report
    if (dateTimeRange != null) {
      filterData = {};
      int from = dateTimeRange!.start.millisecondsSinceEpoch;
      int to = dateTimeRange!.end.millisecondsSinceEpoch;
      filterData["fp"] = {"from": from, "to": to};
    }
    return filterData;
  }
}
