import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_detail_param.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_detail_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/widgets/re_qc_detail_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 're_qc_detail_component.g.dart';

@CshComponent(
    key: ReQcDetailComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: ReQcDetailParam,
    params: ReQcDetailParamKeys.values,
    componentGroup: QcComponentGroup.qcReQcDetailComponentKey)
class ReQcDetailComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_re_qc_detail_component";

  const ReQcDetailComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => ReQcDetailProvider(model.reQcListData!),
        lazy: false,
        child: const ReQcDetailWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
