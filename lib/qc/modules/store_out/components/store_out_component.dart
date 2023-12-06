import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../providers/store_out_provider.dart';
import '../widgets/index.dart';

part 'store_out_component.g.dart';

@CshComponent(
  key: StoreOutComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.StoreOut,
)
class StoreOutComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_store_out_component";

  const StoreOutComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => StoreOutProvider(),
      builder: (buildContext, child) {
        var provider = StoreOutProvider.of(buildContext, listen: false);
        return FutureBuilder(
          future: provider.isLoginFromQC(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var storeOutFacility = Validator.isTrue(snapshot.data) ? StoreOutFacility.qc : StoreOutFacility.trc;
              return StoreOutWidget(storeOutFacility);
            } else {
              return const CshShimmer();
            }
          },
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
