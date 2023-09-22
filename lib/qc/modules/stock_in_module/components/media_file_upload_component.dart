import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../models/media_file_upload_comp_params.dart';
import '../widgets/index.dart';

part 'media_file_upload_component.g.dart';

@CshComponent(
    key: MediaFileUploadComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: MediaFileUploadCompParamKeys.values,
    paramModel: MediaFileUploadCompParam)
class MediaFileUploadComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_media_file_upload_component";

  const MediaFileUploadComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => MediaFileUploadWidget(
          mapData: model.selectedOptionItems,
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
