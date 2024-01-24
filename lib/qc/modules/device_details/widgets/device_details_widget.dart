import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_service.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

class DeviceDetailsWidget extends StatefulWidget {
  final String deviceBarcode;

  const DeviceDetailsWidget(this.deviceBarcode, {super.key});

  @override
  State<DeviceDetailsWidget> createState() => _DeviceDetailsWidgetState();
}

class _DeviceDetailsWidgetState extends State<DeviceDetailsWidget> {
  late String _deviceBarcode;

  @override
  void initState() {
    _deviceBarcode = widget.deviceBarcode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return StreamBuilder(
      stream: DeviceDetailService.getDeviceDetails(_deviceBarcode),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CshShimmer();
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ApiErrorHelper.getErrorMessage(snapshot.error) ?? 'Something went wrong',
                  style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                ),
                const SizedBox(height: Dimens.space_16),
                CshMediumButton(
                    text: l10n.retry,
                    onPressed: () {
                      _onDeviceScanned();
                    }),
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          var data = snapshot.data;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              children: [
                if (!Validator.isNullOrEmpty(data?.barcode)) _row(l10n.deviceBarcode, data!.barcode!, theme),
                if (!Validator.isNullOrEmpty(data?.modelName)) _row(l10n.model, data!.modelName!, theme),
                if (!Validator.isNullOrEmpty(data?.imei)) _row(l10n.imei, data!.imei!, theme),
                if (!Validator.isNullOrEmpty(data?.serialNo)) _row(l10n.serialNo, data!.serialNo!, theme),
                if (!Validator.isNullOrEmpty(data?.location)) _row(l10n.storageLocation, data!.location!, theme),
                if (!Validator.isNullOrEmpty(data?.status)) _row(l10n.currentStatus, data!.status!, theme),
                if (!Validator.isNullOrEmpty(data?.repairStatus)) _row(l10n.repairStatus, data!.repairStatus!, theme),
                if (!Validator.isListNullOrEmpty(data?.channelList))
                  _row(l10n.channelName, data!.channelList!.join(" | "), theme),
                if (data?.stockAge != null) _row(l10n.stockAge, data!.stockAge.toString(), theme),
                if (!Validator.isNullOrEmpty(data?.lotName)) _row(l10n.lotName, data!.lotName.toString(), theme),
                const SizedBox(height: Dimens.space_16),
                CshMediumButton(
                    text: l10n.scanOtherDevice,
                    onPressed: () {
                      _onDeviceScanned();
                    }),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _onDeviceScanned() {
    CshMlScannerUtil().openScanner(
      context,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // close scanner
        setState(() {
          _deviceBarcode = scannedData;
        });
      },
    );
  }

  _row(String title, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 2, fit: FlexFit.tight, child: Text(title, style: theme.textTheme.titleSmall)),
          Flexible(flex: 3, fit: FlexFit.tight, child: Text(value, style: theme.primaryTextTheme.titleMedium)),
        ],
      ),
    );
  }
}
