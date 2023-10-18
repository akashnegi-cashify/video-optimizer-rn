import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/index.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';

import '../screens/index.dart';
import '../type.dart';
import '../l10n.dart';

class ReasonSelectionWidget extends StatefulWidget {
  final List<String> reasonList;
  final int roleType;
  final String? code;
  final int? markId;

  const ReasonSelectionWidget({
    super.key,
    required this.roleType,
    required this.reasonList,
    this.code,
    this.markId,
  });

  @override
  State<ReasonSelectionWidget> createState() => _ReasonSelectionWidgetState();
}

class _ReasonSelectionWidgetState extends State<ReasonSelectionWidget> {
  String? selectedItem;
  late String ctaText;

  @override
  void initState() {
    super.initState();
    ctaText = "";
    if (widget.roleType == RoleType.REPAIR_DEVICE.value) {
      ctaText = 'Mark Repair';
    } else if (widget.roleType == RoleType.DEAD_DEVICE.value) {
      ctaText = 'Mark Dead';
    } else if (widget.roleType == RoleType.ACCEPT_REJECT_DEAD_DEVICE.value) {
      ctaText = 'Next';
    }
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var title = widget.roleType == RoleType.REPAIR_DEVICE.value ? l10n.repair : l10n.dead;
    title = "Select $title Remarks";

    var list = widget.reasonList.map((e) => RadioListItem(e, e, false)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
            child: Column(
              children: [
                CshTextNew.h2(title),
                const SizedBox(height: Dimens.space_16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimens.space_6),
                    child: RadioListWidget(
                      list: list,
                      isShowedInCard: true,
                      onItemSelected: (item) {
                        selectedItem = item.label;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CshBigButton(
                text: ctaText,
                onPressed: () {
                  if (isEmpty(selectedItem)) {
                    CshSnackBar.error(context: context, message: l10n.pleaseSelectAReason);
                    return;
                  }

                  if (widget.roleType != RoleType.ACCEPT_REJECT_DEAD_DEVICE.value) {
                    _onDeviceMark(context);
                  } else {
                    DeviceDeadAcceptRejectScreen.navigateTo(
                      context,
                      selectedReason: selectedItem,
                      markId: widget.markId,
                      code: widget.code,
                    );
                  }
                },
              ),
              if (widget.roleType != RoleType.REPAIR_DEVICE.value) ...[
                const SizedBox(height: Dimens.space_8),
                CshBigButton(
                  text: l10n.update,
                  onPressed: () => _updateRemarks(context,l10n),
                ),
              ],
            ],
          ),
        )
      ],
    );
  }

  void _onDeviceMark(BuildContext context) {
    CshLoading().showLoading(context);
    DeviceDeadRepairServices.reasonSubmission(
            widget.roleType, ReasonSubmitRequest(code: widget.code, remark: selectedItem))
        .listen((event) {
      CshLoading().hideLoading(context);
      if (event.isValid() == true) {
        CshSnackBar.success(context: context, message: event.message ?? 'Success');
        _navigateTo(context);
      } else {
        CshSnackBar.error(context: context, message: event.message ?? "Something Went Wrong");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
      Logger.debug('_ReasonSelectionWidgetState._onDeviceMark', [errorMsg]);
      CshSnackBar.error(context: context, message: errorMsg);
      _navigateTo(context);
    });
  }

  void _updateRemarks(BuildContext context,L10n l10n) {
    if (isEmpty(selectedItem)) {
      CshSnackBar.error(context: context, message: "Please select a reason");
      return;
    }

    if (widget.markId != null) {
      __updateRemarks(context, widget.markId,l10n);
    } else {
      CshLoading().showLoading(context);
      DeviceDeadRepairServices.getScanDeviceDetail(widget.code ?? '').listen((event) {
        CshLoading().hideLoading(context);
        __updateRemarks(context, event?.id,l10n);
      }, onError: (error, stackTrace) {
        CshLoading().hideLoading(context);
        var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong;
        Logger.debug('_ReasonSelectionWidgetState._onDeviceMark', [errorMsg]);
        CshSnackBar.error(context: context, message: errorMsg);
        Navigator.popUntil(context, ModalRoute.withName(DeviceDeadRepairScreen.route));
      });
    }
  }

  void __updateRemarks(BuildContext context, int? updateReasonSubmissionId,L10n l10n) {
    CshLoading().showLoading(context);
    var req = ReasonSubmitRequest(
      code: widget.code ?? '',
      remark: selectedItem,
      actionRemark: selectedItem,
      id: updateReasonSubmissionId,
    );
    DeviceDeadRepairServices.updateReasonSubmissionId(req).listen((event) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: event?.confirmMessage ?? l10n.success);
      Navigator.popUntil(context, ModalRoute.withName(DeviceDeadRepairScreen.route));
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong;
      Logger.debug('_ReasonSelectionWidgetState._onDeviceMark', [errorMsg]);
      CshSnackBar.error(context: context, message: errorMsg);
    });
  }

  void _navigateTo(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(QcActionScreen.route));
  }
}
