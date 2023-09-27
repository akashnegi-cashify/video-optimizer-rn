import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/inventory_home_provider.dart';
import '../widgets/inventory_home_widget.dart';

part 'inventory_home_component.g.dart';

@CshComponent(
    key: InventoryHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.inventoryHomeComponentKey)
class InventoryHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_inventory_home";

  const InventoryHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<InventoryHomeProvider>(
      create: (_) => InventoryHomeProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = InventoryHomeProvider.of(insideContext);
        if (provider.isDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: Dimens.space_30,
                width: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            appBar: CshHeader(
              l10n.delivery,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage!,
                      style: theme.primaryTextTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const InventoryHomeWidget();
        }
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
