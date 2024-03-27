import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:provider/provider.dart';

import '../resources/audit_service.dart';
import 'package:core/core.dart';

class AuditQuestionsProvider extends CshChangeNotifier {
  static AuditQuestionsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AuditQuestionsProvider>(context, listen: listen);
  }

  AuditQuestionResponse? auditData;
  bool isQuestionsDataLoading = true;
  String? errMessage;

  AuditQuestionsProvider(String scannedData) {
    getAuditQuestionsData(scannedData);
  }

  getAuditQuestionsData(String scannedBarcode) {
    AuditDataServices.getAuditQuestionnaire(scannedBarcode).listen((event) {
      if (event != null) {
        auditData = event.auditQuestionResponse;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      errMessage = errorMessage;
    }, onDone: () {
      isQuestionsDataLoading = false;
      notifyListeners();
    });
  }

  onQuestionOptionSelected(int questionId, String selectedOption) {
    if (!Validator.isListNullOrEmpty(auditData?.auditQuestionList)) {
      int index = auditData!.auditQuestionList!.indexWhere((element) => element.questionId == questionId);
      if (index != -1) {
        auditData!.auditQuestionList![index].selectedOption = selectedOption;
      }
    }
    notifyListeners();
  }
}
