import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../l10n.dart';
import '../models/device_receive_response.dart';
import '../providers/device_receive_provider.dart';

part 'device_receive_component.g.dart';

@CshComponent(
    key: DeviceReceiveComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.deviceReceiveComponentKey)
class DeviceReceiveComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "device_receive_component";

  const DeviceReceiveComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => DeviceReceiveProvider(),
      lazy: false,
      builder: (builderContext, _) {
        var provider = DeviceReceiveProvider.of(builderContext, listen: false);
        return TRCScannerWidget(
          onScanDetected: (String scannedData, MlScannerController? controller) {
            controller?.stop();
            CshLoading().showLoading(context);
            provider.onDeviceScanned(scannedData).then((value) {
              CshLoading().hideLoading(context);
              _showDeviceDetails(value, context, l10n).whenComplete(() {
                FocusScope.of(context).unfocus();
                controller?.start();
              });
            }, onError: (error) {
              controller?.start();
              CshLoading().hideLoading(context);
              CshSnackBar.error(context: context, message: error.toString());
            });
          },
        );
      },
    );
  }

  Widget _buildTitleValue(String title, String value, ThemeData theme) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyLarge,
        text: "$title : ",
        children: [TextSpan(text: value, style: theme.textTheme.titleMedium)],
      ),
    );
  }

  Future _showDeviceDetails(DeviceReceiveData value, BuildContext context, L10n l10n) {
    var theme = Theme.of(context);
    return showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleValue(l10n.deviceBarcode, value.deviceBarcode.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            _buildTitleValue(l10n.productTitle, value.productTitle.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            _buildTitleValue(l10n.status, value.status.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            _buildTitleValue(l10n.repairType, value.repairType.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            SizedBox(
              width: double.infinity,
              child: CshMediumButton(text: l10n.close, onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
