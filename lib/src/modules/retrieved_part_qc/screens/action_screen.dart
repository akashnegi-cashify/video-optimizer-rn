import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../providers/action_provider.dart';

part 'action_screen.g.dart';

@CshPage(key: ActionScreen.pageKey, pageGroup: PageGroup.actionPageKey)
class ActionScreen extends BaseScreen {
  static const String pageKey = "TRC_action_screen";
  static const String route = "/action_screen";

  const ActionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return PageWidget(
      pageKey: pageKey,
      setProviders: (BuildContext insideContext) => [
        ChangeNotifierProvider<ActionProvider>(
          create: (_) => ActionProvider(),
          lazy: false,
        )
      ],
    );
  }
}
