import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/retrieved_parts_data_details_param.dart';
import '../widgets/retrieved_parts_data_details_widget.dart';

part 'retrieved_parts_data_details_component.g.dart';

@CshComponent(
    key: RetrievedPartsDataDetailsComponents.COMP_KEY,
    paramModel: RetrievedDataDetailsParamModel,
    params: RetrievedDataDetailsParamModelKeys.values,
    componentGroup: ComponentGroup.retrievedPartsDataDetailsComponentKey)
class RetrievedPartsDataDetailsComponents extends StatelessComponent {
  static const String COMP_KEY = "TRC_retrieved_parts_data_details";

  const RetrievedPartsDataDetailsComponents(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return RetrievedPartsDataDetailsWidget(
        dataModel: param.dataModel,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return null;
  }
}
