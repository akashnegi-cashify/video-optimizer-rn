import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/widgets/pending_dispatch_provider_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'pending_dispatch_provider_list_component.g.dart';

@CshComponent(
    key: PendingDispatchProviderListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.pendingDispatchProviderListComponentKey)
class PendingDispatchProviderListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "OMS_pending_dispatch_provider_list_component";

  const PendingDispatchProviderListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const PendingDispatchProviderListWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
