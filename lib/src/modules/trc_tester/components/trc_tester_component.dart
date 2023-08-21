import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'trc_tester_component.g.dart';

@CshComponent(
    key: TrcTesterComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcTesterComponentKey)
class TrcTesterComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_trc_tester_component";

  const TrcTesterComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: SizedBox(
        width: double.infinity,
        child: CshBigButton(
          text: 'Trc Tester',
          onPressed: () {
            Navigator.pushNamed(context, CalculatorScannerScreen.route);
          },
        ),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
