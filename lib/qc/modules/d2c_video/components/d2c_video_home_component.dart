import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

part 'd2c_video_home_component.g.dart';

@CshComponent(
    key: D2cVideoHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcD2cVideoHomeComponentKey)
class D2cVideoHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_d2c_video_home_component";

  const D2cVideoHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    return Padding(
      padding: EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Dimens.space_16,
        children: [
          CshBigButton(
            text: l10n.genericDeviceMedia,
            onPressed: () {
              CshMlScannerUtil().openScanner(
                context,
                onScanned: (scannedData, controller) {
                  Navigator.pop(context); // dismiss scanner screen
                  D2CVideoScreen.navigate(context, scannedData);
                },
              );
            },
          ),
          CshBigButton(
            text: l10n.pendingVideoLot,
            onPressed: () {
              // TODO: move to lot listing screen
            },
          ),
        ],
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
