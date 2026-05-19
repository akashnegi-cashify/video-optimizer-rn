import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/disputed_image_capture_param.dart';
import '../providers/dispute_image_capture_provider.dart';
import '../widgets/disputed_image_capture_widget.dart';

part 'disputed_image_capture_component.g.dart';

@CshComponent(
    key: DisputedImageCaptureComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.disputedImageCaptureComponentKey,
    params: DisputedImageCaptureScreenParamKeys.values,
    paramModel: DisputedImageCaptureScreenParam)
class DisputedImageCaptureComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "disputed_image_capture";

  const DisputedImageCaptureComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return ChangeNotifierProvider<DisputeImageCaptureProvider>(
        create: (_) => DisputeImageCaptureProvider(param.barcode ?? ""),
        lazy: false,
        child: DisputedImageCaptureWidget(
          barcode: param.barcode ?? "",
        ),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
