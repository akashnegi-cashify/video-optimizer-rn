import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/nps_service.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/nps/widget/nps_widget.dart';

void showNpsDialog(BuildContext context) async {
  try {
    var questionResponseData = await getNpsQuestion();
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

Future<NpsResponseData> getNpsQuestion() {
  var completer = Completer<NpsResponseData>();
  NpsService.getNpsQuestions().listen((event) {
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
