import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/nps_service.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_type.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_selected_value.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:provider/provider.dart';

class NpsProvider extends QcTrcServiceInitProvider {
  final Map<int, NpsSelectedValue> _npsSelectedValueMap = {};
  String? _transactionId;
  int? _pageNo;
  int? _totalQuestions;

  NpsProvider(this._transactionId, this._pageNo, this._totalQuestions);

  static NpsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<NpsProvider>(context, listen: listen);
  }

  void setNpsRating(NpsQuestionData selectedRating) {
    var value = NpsSelectedValue(NpsQuestionType.rating.value);
    value.npsValue = selectedRating;
    _npsSelectedValueMap[selectedRating.questionId!] = value;
    notifyListeners();
  }

  void setNpsText(int questionId, String remarks) {
    if (Validator.isNullOrEmpty(remarks)) {
      _npsSelectedValueMap.remove(questionId);
      notifyListeners();
      return;
    }
    var value = NpsSelectedValue(NpsQuestionType.text.value);
    value.npsValue = remarks;
    _npsSelectedValueMap[questionId] = value;
    notifyListeners();
  }

  bool isValueEntered() {
    if (_npsSelectedValueMap.isEmpty) {
      return false;
    }

    return _npsSelectedValueMap.length == _totalQuestions;
  }

  Future<void> onSubmit() {
    var completer = Completer<void>();
    Map<String, dynamic> requestBody = {};
    requestBody["txnId"] = _transactionId;
    requestBody["pageNo"] = _pageNo;

    List<Map<String, dynamic>> questionListBody = [];
    _npsSelectedValueMap.forEach((key, value) {
      Map<String, dynamic> questionBody = {};
      questionBody["questionId"] = key;
      if (value.npsQuestionType == NpsQuestionType.rating.value) {
        questionBody["selectedOptionIds"] = value.npsValue;
      } else if (value.npsQuestionType == NpsQuestionType.text.value) {
        questionBody["value"] = value.npsValue;
      }
      questionListBody.add(questionBody);
    });
    requestBody["questions"] = questionListBody;
    NpsService.submitNpsQuestions(requestBody, service: service).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
