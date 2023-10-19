import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/screens/device_receive_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_home_screen.dart';
import 'package:flutter_trc/qc/modules/qc_actions/resources/services.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/qc_guard_home_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/stock_transfer_list_screen.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_screen.dart';
import 'package:flutter_trc/qc/modules/store_out/screens/index.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../../../../src/modules/elss/common_screen/elss_home_screen.dart';
import '../../dead_repair/screens/index.dart';
import '../../dead_repair/type.dart';
import '../../dispatch_lot/screens/dispatch_lot_screen.dart';
import '../../pre_dispatch/screens/index.dart';
import '../../qc_tester/home/screens/qc_tester_home_screen.dart';
import '../../stock_in_module/screens/search_item_screen.dart';
import '../l10n.dart';
import '../models/qc_action_comp_config.dart';

class QCActionWidget extends StatelessWidget {
  final QcActionConfig? configData;

  const QCActionWidget({
    Key? key,
    this.configData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QcRolePermissionWidget(
              role: QcRole.qcElss,
              child: CshBigButton(
                text: configData?.button1Text ?? l10n.elss,
                onPressed: () {
                  ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: true);
                  Navigator.of(context).pushNamed(ElssHomeScreen.route, arguments: args);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: configData?.button2Text ?? l10n.deviceTesting,
              onPressed: () {
                Navigator.of(context).pushNamed(QcTesterHomeScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.externalRecording,
              onPressed: () {
                Navigator.of(context).pushNamed(ExternalAuditHomeScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.stockIn,
              onPressed: () {
                Navigator.of(context).pushNamed(SearchItemScreen.route);
              },
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleDispatch,
              child: CshBigButton(
                text: l10n.lotDispatch,
                onPressed: () {
                  Navigator.of(context).pushNamed(DispatchLotScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            QcRolePermissionWidget(
              role: QcRole.roleDispatch,
              child: CshBigButton(
                text: l10n.preDispatch,
                onPressed: () {
                  Navigator.of(context).pushNamed(PreDispatchLotScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.reQc,
              onPressed: () {
                Navigator.of(context).pushNamed(ReQcListScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            QcRolePermissionWidget(
              role: QcRole.roleStockTransfer,
              child: CshBigButton(
                text: l10n.stockTransfer,
                onPressed: () {
                  Navigator.of(context).pushNamed(StockTransferListScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            QcRolePermissionWidget(
              role: QcRole.roleStoreIn,
              child: CshBigButton(
                text: l10n.storeIn,
                onPressed: () {
                  _storeInOptions(context, l10n);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            SizedBox(
              width: double.infinity,
              child: CshBigButton(
                text: l10n.storeOut,
                onPressed: () {
                  Navigator.of(context).pushNamed(StoreOutScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.receiveDevice,
              onPressed: () {
                Navigator.pushNamed(context, DeviceReceiveScreen.route);
              },
            ),



            const SizedBox(height: Dimens.space_16),
            SizedBox(
              width: double.infinity,
              child: CshBigButton(
                text: l10n.repairDevice,
                onPressed: () {
                  CshMlScannerUtil().openScanner(context, onScanned: (scanValue, controller) {
                    if (isNotEmpty(scanValue)) {
                      _fetchReasonList(context).then((value) {
                        ReasonSelectionScreen.navigateTo(
                          context,
                          header: 'Repair Device',
                          status: RoleType.REPAIR_DEVICE.value,
                          reasonList: value,
                          code: scanValue,
                        );
                      });
                    }
                  });
                },
              ),
            ),

            const SizedBox(height: Dimens.space_16),
            SizedBox(
              width: double.infinity,
              child: CshBigButton(
                text: l10n.deadDevice,
                onPressed: () {
                  DeviceDeadRepairScreen.navigateTo(context);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),

            QcRolePermissionWidget(
              role: QcRole.roleGUARD,
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshBigButton(
                text: l10n.guardRole,
                onPressed: () {
                  Navigator.pushNamed(context, QcGuardHomeScreen.route);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _storeInOptions(BuildContext context, L10n l10n) {
    var theme = Theme.of(context);
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: CshTextNew.h3(
              l10n.storeIn,
            ),
            contentPadding: const EdgeInsets.all(Dimens.space_12),
            actions: <Widget>[
              TextButton(
                child: CshTextNew(
                  l10n.binStoreIn,
                  textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
                ),
                onPressed: () {
                  _onPressed(context, true);
                },
              ),
              TextButton(
                child: CshTextNew(
                  l10n.storeIn,
                  textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
                ),
                onPressed: () {
                  _onPressed(context, false);
                },
              ),
            ],
          );
        });
  }


  void _onPressed(BuildContext context, bool isBinStoreIn) {
    Navigator.pop(context);
    StoreInScreen.navigateTo(context, isBinStoreIn);
  }

  Future<List<String>> _fetchReasonList(BuildContext context) {
    var completer = Completer<List<String>>();
    CshLoading().showLoading(context);
    QcActionServices.fetchRepairReasonList().listen((event) {
      CshLoading().hideLoading(context);

      if (event?.isValid() == true) {
        completer.complete(ArrayUtil.removeNullItems(event?.data ?? []));
      } else {
        completer.completeError(event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
      Logger.debug('QCActionWidget._fetchReasonList', [errorMsg]);
    });

    return completer.future;
  }
}
