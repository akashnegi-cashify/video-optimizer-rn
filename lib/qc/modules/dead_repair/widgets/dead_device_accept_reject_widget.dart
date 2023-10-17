import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dead_repair/type.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/index.dart';
import '../resources/index.dart';
import '../screens/index.dart';
import 'index.dart';

class DeviceDeadAcceptRejectWidget extends StatelessWidget {
  final int? markId;
  final String? barcode;
  final String? preSelectedRemark;

  const DeviceDeadAcceptRejectWidget({super.key, this.markId, this.barcode, this.preSelectedRemark});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => DeviceDeadAcceptRejectProvider(
        markId: markId,
        barcode: barcode,
        preSelectedRemark: preSelectedRemark,
      ),
      child: Builder(builder: (builderContext) {
        var provider = DeviceDeadAcceptRejectProvider.of(builderContext);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(alignment: Alignment.topCenter, child: CshTextNew.h3(l10n.acceptRejectDeadRemark)),
              const SizedBox(height: Dimens.space_16),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_4),
                  child: CshCard(child: const AddRemoveSKU()),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Flexible(
                child: CshShimmer(
                  show : provider.deadReasonList.status == RequestStatus.initial,
                  child: AcceptRejectRemarksWidget(
                    onRepairReject: () => {_onRepairReject(builderContext)},
                    onDeadAccept: () => {_onDeadAccept(builderContext)},
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_4),
                child: CshCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CshDropDown(
                        items: provider.level,
                        selectedItem: provider.level.firstWhere((element) => element.extraData == true),
                        onChanged: provider.onLevelChange,
                      ),
                      const SizedBox(height: Dimens.space_24),
                      Selector<DeviceDeadAcceptRejectProvider, DropDownItem>(
                        builder: (BuildContext context, value, Widget? child) {
                          return CshBigButton(
                            text: l10n.repairDone,
                            onPressed: value.id != null ? () => _onRepairDone(context, l10n) : null,
                          );
                        },
                        selector: (context, provider) {
                          return provider.getSelectedLevel();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
            ],
          ),
        );
      }),
    );
  }

  void _onRepairReject(BuildContext context) {
    _submitRequest(context, DeadDeviceRequestType.REPAIR_REJECT);
  }

  void _onDeadAccept(BuildContext context) {
    _submitRequest(context, DeadDeviceRequestType.ACCEPT_DEAD);
  }

  void _onRepairDone(BuildContext context, L10n l10n) {
    var provider = DeviceDeadAcceptRejectProvider.of(context, listen: false);

    if (provider.skuList.isEmpty) {
      _showMarkDeadConfirmationDialog(context, l10n);
      return;
    }
    _submitRequest(context, DeadDeviceRequestType.REPAIR_DONE);
  }

  void _showMarkDeadConfirmationDialog(BuildContext context, L10n l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: CshTextNew.h3(l10n.alert),
          content: CshTextNew.h3(l10n.markDeadWithoutSku(barcode ?? '')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CshTextNew.h3(l10n.no)),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _submitRequest(context, DeadDeviceRequestType.REPAIR_DONE);
                },
                child: CshTextNew.h3(l10n.yes)),
          ],
        );
      },
    );
  }

  void _submitRequest(BuildContext context, DeadDeviceRequestType requestType) {
    var provider = DeviceDeadAcceptRejectProvider.of(context, listen: false);
    AcceptRejectDeadRequest request = AcceptRejectDeadRequest(
      markId: provider.markId,
      skus: provider.skuList,
      remark: provider.preSelectedRemark,
      repairLevel: provider.getSelectedLevel().id,
      actionRemark: provider.getSelectedRemark()?.id,
      requestType: requestType,
    );
    CshLoading().showLoading(context);
    provider.submitDeadDeviceRequest(request).listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isValid() == true) {
        CshSnackBar.success(context: context, message: event?.confirmMessage ?? "Success");
        Navigator.popUntil(context, ModalRoute.withName(DeviceDeadRepairScreen.route));
      } else {
        CshSnackBar.error(context: context, message: event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('DeviceDeadAcceptRejectProvider.fetchDeadReasonList', [errorMsg]);
      CshSnackBar.error(context: context, message: errorMsg);
    });
  }
}
