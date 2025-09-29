import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dead_repair/providers/dead_device_provider.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/utils/csh_ml_scanner_util.dart';
import '../l10n.dart';
import '../screens/index.dart';
import '../type.dart';

class DeadDeviceWidget extends StatelessWidget {
  const DeadDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => DeadDeviceProvider(),
      child: Builder(builder: (builderContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CshBigButton(
                text: l10n.markDead.toUpperCase(),
                onPressed: () => _openScanner(builderContext, roleType: RoleType.DEAD_DEVICE.value, l10n: l10n),
              ),
              const SizedBox(
                height: Dimens.space_16,
              ),
              CshBigButton(
                text: l10n.accpetRejectDead.toUpperCase(),
                onPressed: () =>
                    _openScanner(builderContext, roleType: RoleType.ACCEPT_REJECT_DEAD_DEVICE.value, l10n: l10n),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _openScanner(BuildContext context, {required int roleType, required L10n l10n}) {
    var provider = DeadDeviceProvider.of(context, listen: false);
    provider.roleType = roleType;

    CshMlScannerUtil().openScanner(context, onScanned: (scanValue, controller) {
      if (isNotEmpty(scanValue)) {
        if (roleType == RoleType.DEAD_DEVICE.value) {
          _fetchReasonList(
            context,
            scanValue.trim(),
            l10n: l10n,
          );
        } else {
          _getScanDeviceDetail(context, scanValue.trim(), l10n);
        }
      } else {
        CshSnackBar.error(context: context, message: '');
      }
    });
  }

  void _fetchReasonList(BuildContext context, String scanValue, {int? markId, required L10n l10n}) {
    var provider = DeadDeviceProvider.of(context, listen: false);
    CshLoading().showLoading(context);

    provider.fetchReasonList().then((value) {
      CshLoading().hideLoading(context);

      ReasonSelectionScreen.navigateTo(
        context,
        header: l10n.deadDevice,
        status: provider.roleType,
        reasonList: value,
        code: scanValue,
        markId: markId,
      );
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  void _getScanDeviceDetail(
    BuildContext context,
    String scanValue,
    L10n l10n,
  ) {
    var provider = DeadDeviceProvider.of(context, listen: false);
    CshLoading().showLoading(context);

    provider.fetchScanDeviceDetail(scanValue).then((value) {
      CshLoading().hideLoading(context);
      _fetchReasonList(context, scanValue, markId: value.id, l10n: l10n);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
    //   fetchScanDeviceDetail
  }
}
