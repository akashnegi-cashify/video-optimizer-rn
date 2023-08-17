import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/upload_eway_bill_param.dart';
import '../widgets/upload_eway_bill_widget.dart';

part 'upload_eway_bill_component.g.dart';

@CshComponent(
    key: UploadEwayBillComponent.COMP_KEY,
    componentGroup: ComponentGroup.uploadEwayBillComponentKey,
    paramModel: UploadEwayBillParams,
    params: UploadEwayBillParamsKeys.values,
    configModel: NoneConfigModel)
class UploadEwayBillComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "upload_eway_bill_comp";

  const UploadEwayBillComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return UploadEwayBillWidget(
        shipmentId: (param.shipmentId != null) ? param.shipmentId!.toString() : "",
        facilityId: (param.facilityId != null) ? param.facilityId! : -1,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
