import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/action_item_params.dart';
import '../providers/action_provider.dart';

part 'action_screen.g.dart';

@CshPage(
  key: ActionScreen.pageKey,
  pageGroup: PageGroup.actionPageKey,
  params: ActionItemParamKey.values,
)
class ActionScreenArgumentsKey extends BaseArguments {
final String? barcode;


  ActionScreenArgumentsKey({
    this.barcode,
  }) : super(ActionScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[ActionItemParamKey.barcode.value] = barcode;
    return data;
  }
}

class ActionScreen extends BaseScreen<ActionScreenArgumentsKey> {
  static const String pageKey = "TRC_action_screen";
  static const String route = "/action_screen";

  const ActionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      initialValue: args?.toJson(),
      pageKey: pageKey,
      setProviders: (BuildContext insideContext) => [
        ChangeNotifierProvider<ActionProvider>(
          create: (_) => ActionProvider(args?.barcode ?? ""),
          lazy: false,
        )
      ],
    );
  }
}
