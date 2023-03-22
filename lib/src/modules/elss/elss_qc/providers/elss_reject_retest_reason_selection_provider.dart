import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_success_response.dart';
import 'package:flutter_trc/src/modules/elss/common_resources/elss_service.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/reject_retest_reason_list_response.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/reject_retest_reason_selection_modal.dart';
import 'package:provider/provider.dart';

class ElssRejectRetestReasonSelectionProvider extends CshChangeNotifier {
  static ElssRejectRetestReasonSelectionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ElssRejectRetestReasonSelectionProvider>(context, listen: listen);
  }

  List<RejectRetestReasonListItem>? reasonList;
  String? screenErrorMessage;
  bool isScreenLoading = true;
  final ReasonType type;

  ElssRejectRetestReasonSelectionProvider(this.type) {
    _getReasonList();
  }

  void _getReasonList() {
    ElssService.getElssRejectReasonList(type).listen((event) {
      reasonList = event?.reasonList;
      screenErrorMessage = null;
    }, onError: (error) {
      screenErrorMessage = ApiErrorHelper.getErrorMessage(error);
    }, onDone: () {
      isScreenLoading = false;
      notifyListeners();
    });
  }

  Future<bool> submitElssRejectRetest(String barcode, int selectedIndex) {
    var completer = Completer<bool>();
    try {
      var reasonItem = reasonList![selectedIndex];
      Stream<ElssSuccessResponse?>? apiStream;
      if (type == ReasonType.reject) {
        apiStream = ElssService.rejectElss(barcode, reasonItem.id);
      } else {
        apiStream = ElssService.retestingElss(barcode, reasonItem.id);
      }
      apiStream.listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.completeError("Something Went Wrong!!");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  bool get isReasonTypeReject => (type == ReasonType.reject);

  bool isShowErrorScreen() {
    return !Validator.isTrue(isScreenLoading) && !Validator.isNullOrEmpty(screenErrorMessage);
  }
}
