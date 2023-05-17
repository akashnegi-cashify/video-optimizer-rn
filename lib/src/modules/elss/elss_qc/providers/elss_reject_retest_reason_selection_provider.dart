import 'dart:async';

import 'package:collection/collection.dart';
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

  Future<bool> submitElssRejectRetest(String barcode) {
    var completer = Completer<bool>();
    try {
      List<int?> selectedReasonsList = [];
      reasonList?.forEach((element) {
        if (element.isSelected) {
          selectedReasonsList.add(element.id);
        }
      });
      Stream<ElssSuccessResponse?>? apiStream;
      if (type == ReasonType.reject) {
        apiStream = ElssService.rejectElss(barcode, selectedReasonsList);
      } else {
        apiStream = ElssService.retestingElss(barcode, selectedReasonsList);
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

  bool isReasonSelected() {
    var item = reasonList?.firstWhereOrNull((element) => element.isSelected);
    if (item == null) {
      return false;
    }
    return true;
  }

  void onReasonItemSelected(bool? value, int id) {
    var item = reasonList?.firstWhereOrNull((element) => element.id == id);
    item?.isSelected = value ?? false;
    notifyListeners();
  }
}
