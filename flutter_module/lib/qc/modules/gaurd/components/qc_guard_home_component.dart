import 'package:builder_component/builder_component.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/qc_guard_home_provider.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_device_counting_list_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:provider/provider.dart';

part 'qc_guard_home_component.g.dart';

@CshComponent(
    key: QcGuardHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcGuardHomeComponentKey)
class QcGuardHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_guard_home_component";

  const QcGuardHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(create: (_) => QcGuardHomeProvider(), child: const _GuardWidget());
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _GuardWidget extends StatelessWidget {
  const _GuardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = QcGuardHomeProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshBigButton(
            text: "Device Counting",
            onPressed: () {
              Navigator.pushNamed(context, GuardDeviceCountingListScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: "Scan Qr Code",
            onPressed: () {
              _onScannerClicked(context, provider);
            },
          )
        ],
      ),
    );
  }

  _onScannerClicked(BuildContext context, QcGuardHomeProvider provider) {
    CshMlScannerUtil().openScanner(
      context,
      hintText: "Scan Barcode on bulk sales app",
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // close scanner
        CshLoading().showLoading(context);
        provider.entryScanData(scannedData).then((status) {
          CshLoading().hideLoading(context);
          _showEntryScanStatusDialog(context, status, provider);
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error);
        });
      },
    );
  }

  _showEntryScanStatusDialog(BuildContext context, String status, QcGuardHomeProvider provider) {
    showPopup(
      context,
      title: status,
      actions: [
        CshBigButton(
            text: "Scan Other",
            onPressed: () {
              Navigator.pop(context); // dismiss dialog
              _onScannerClicked(context, provider);
            }),
        CshBigButton(
            text: "Ok",
            onPressed: () {
              Navigator.pop(context); // dismiss dialog
            }),
      ],
    );
  }
}
