import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/screens/device_receive_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_home_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/stock_transfer_list_screen.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_screen.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';

import '../../../../src/modules/elss/common_screen/elss_home_screen.dart';
import '../../dispatch_lot/screens/dispatch_lot_screen.dart';
import '../../dispatch_lot/screens/index.dart';
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
                _storeInOptions(context);
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
        ],
      ),
    );
  }

  void _storeInOptions(BuildContext context) {
    showResponsiveOverlayPanel(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OverlayHeader(label: 'Store In'),
                const SizedBox(height: Dimens.space_24),
                Flexible(
                  child: Row(
                    children: [
                      Expanded(child: CshBigButton(text: 'Bin Store In', onPressed: () => _onPressed(context, true))),
                      const SizedBox(width: Dimens.space_8),
                      Expanded(child: CshBigButton(text: 'Store In', onPressed: () => _onPressed(context, false))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _onPressed(BuildContext context, bool isBinStoreIn) {
    Navigator.pop(context);
    StoreInScreen.navigateTo(context, isBinStoreIn);
  }
}
