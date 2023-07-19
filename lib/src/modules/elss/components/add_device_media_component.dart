import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../common_models/add_device_media_comp_config.dart';
import '../common_models/add_device_media_comp_param.dart';
import '../elss_trc/screens/add_device_media_screen_trc.dart';

part 'add_device_media_component.g.dart';

@CshComponent(
    key: AddDeviceMediaComponent.COMP_KEY,
    configModel: AddDeviceMediaCompConfig,
    paramModel: AddDeviceMediaCompParam,
    params: AddDeviceMediaCompParamKeys.values,
    componentGroup: ComponentGroup.addDeviceMediaComponentKey)
class AddDeviceMediaComponent extends StatelessComponent<AddDeviceMediaCompConfig> {
  static const String COMP_KEY = "TRC_add_device_media";

  const AddDeviceMediaComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return AddDeviceMedia(
        setS3DataToParticularItem: param.addDeviceMediaArgumentsTrc?.onImageUploadCallback,
        listOfPartsImages: param.addDeviceMediaArgumentsTrc?.partsImage,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return AddDeviceMediaCompConfig.fromConfig;
  }
}
