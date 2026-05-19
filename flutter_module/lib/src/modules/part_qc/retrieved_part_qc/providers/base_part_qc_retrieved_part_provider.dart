import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/models/qc_repost_response.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/resources/retrieved_part_qc_service.dart';
import 'package:provider/provider.dart';

abstract class BasePartQcRetrievedPartProvider extends CshChangeNotifier {
  static BasePartQcRetrievedPartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<BasePartQcRetrievedPartProvider>(context, listen: listen);
  }

  BasePartQcRetrievedPartProvider() {
    fetchQcReportData();
  }

  ListState<QcRepostCategoryResponseList> qcReportData = ListState(status: RequestStatus.initial);

  Map<String, dynamic>? getFilterData();

  fetchQcReportData() {
    qcReportData = ListState(status: RequestStatus.initial);
    notifyListeners();

    RetrievedPartQcService.getQcReport(bodyData: getFilterData()).listen((event) {
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
}
