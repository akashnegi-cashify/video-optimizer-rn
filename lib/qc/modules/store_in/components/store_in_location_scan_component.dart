import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/providers/store_in_provider.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../models/index.dart';
import '../widgets/index.dart';

part 'store_in_location_scan_component.g.dart';

@CshComponent(
  key: StoreInLocationScanComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.StoreIn,
  paramModel: StoreInLocationScanCompParam,
  params: StoreInLocationScanCompParamKeys.values,
)
class StoreInLocationScanComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_store_in_location_scan_component";

  const StoreInLocationScanComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((paramModel) => ChangeNotifierProvider(
          create: (_) => StoreInProvider(locQrCode: paramModel.barcode, isBinStoreIn: paramModel.binStoreIn ?? false),
          lazy: false,
          child: const StoreInLocationScanWidget(),
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
