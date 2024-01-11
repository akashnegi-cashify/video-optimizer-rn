import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/widgets/dispatch_finish_widget.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/models/complete_dispatch_param_model.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/providers/complete_dispatch_provider.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'complete_dispatch_component.g.dart';

@CshComponent(
    key: CompleteDispatchComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.completeDispatchComponentKey,
    params: CompleteDispatchParamModelKeys.values,
    paramModel: CompleteDispatchParamModel)
class CompleteDispatchComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "OMS_complete_dispatch_component";

  const CompleteDispatchComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => CompleteDispatchProvider(model.deliveryPartnerKey ?? ""),
        lazy: false,
        child: const DispatchFinishedWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
