import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_store_out_param_model.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/storage_device_list_provider.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../widgets/storage_device_list_widget.dart';

part 'storage_device_list_component.g.dart';

@CshComponent(
  key: StorageDeviceListComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcStorageDeviceListComponentKey,
  params: StStoreOutParamModelKeys.values,
  paramModel: StStoreOutParamModel,
)
class StorageDeviceListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_storage_device_list_component";

  const StorageDeviceListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (model) => ChangeNotifierProvider(
        create: (context) => StorageDeviceListProvider(model.lotId!),
        child: const StorageDeviceListWidget(),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
