import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/nps_service.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/nps/widget/nps_widget.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

void showNpsDialog(BuildContext context, LoginTypes loginType) async {
  try {
    var questionResponseData = await getNpsQuestion(loginType);
    showCshBottomSheet(
        context: context,
        child: Builder(builder: (innerContext) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(innerContext).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [NpsWidget(questionResponseData)],
            ),
          );
        }));
  } catch (e) {
    Logger.debug('mydebug-----showNpsDialog', [e]);
  }
}

Future<NpsResponseData> getNpsQuestion(LoginTypes loginType) {
  var completer = Completer<NpsResponseData>();
  BaseService service;
  if (loginType == LoginTypes.qcLogin) {
    service = QcService();
  } else {
    service = TrcService();
  }
  NpsService.getNpsQuestions(service: service).listen((event) {
    if (event.npsResponse?.transactionId == null) {
      completer.completeError("No NPS questions found");
      return;
    }
    completer.complete(event.npsResponse);
  }, onError: (error) {
    completer.completeError(error);
  });

  return completer.future;
}
