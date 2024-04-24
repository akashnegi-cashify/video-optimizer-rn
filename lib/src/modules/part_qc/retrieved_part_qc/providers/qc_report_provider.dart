import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/pq_services.dart';
import '../models/qc_repost_response.dart';
import '../resources/retrieved_part_qc_service.dart';

class QcRepostProvider extends CshChangeNotifier {
  static QcRepostProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<QcRepostProvider>(context, listen: listen);
  }

  ListState<QcRepostCategoryResponseList> qcReportData = ListState(status: RequestStatus.initial);
  List<String> queries = [];

  QcRepostProvider() {
    fetchQcReportData();
  }

  DateTimeRange? dateTimeRange;

  fetchQcReportData() {
    qcReportData = ListState(status: RequestStatus.initial);
    notifyListeners();
    Map<String, dynamic>? filterData;
    if (dateTimeRange != null) {
      filterData = {};
      int from = dateTimeRange!.start.millisecondsSinceEpoch;
      int to = dateTimeRange!.end.millisecondsSinceEpoch;
      filterData["fp"] = {"from": from, "to": to};
    }

    RetrievedPartQcService.getQcReport(bodyData: filterData).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.categoryList)) {
        qcReportData = ListState(status: RequestStatus.success, items: event!.categoryList!, errorMsg: null);
      } else {
        qcReportData = ListState(status: RequestStatus.success, items: [], errorMsg: "No Report found!!");
      }
    }, onError: (error) {
      String apiErr = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      qcReportData = ListState(status: RequestStatus.failure, items: [], errorMsg: apiErr);
    }, onDone: () {
      notifyListeners();
    });
  }

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

  Future<bool> receivePart(String partBarcode) {
    var completer = Completer<bool>();
    PartQcServiceElss.receiveRetrievedParts(partBarcode).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete(true);
      } else {
        completer.completeError(event?.errorMsg ?? "No data found");
      }
    }, onError: (error, stackTrace) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  List<QcRepostCategoryResponseList?> getSearchResults(List<QcRepostCategoryResponseList?> masterData) {
    if (queries.isEmpty) {
      return qcReportData.data!;
    } else {
      return qcReportData.data!.where((element) => queries.contains(element?.productCategory ?? "")).toList();
    }
  }
}
