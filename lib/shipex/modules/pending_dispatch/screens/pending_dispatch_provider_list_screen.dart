import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'pending_dispatch_provider_list_screen.g.dart';

@CshPage(key: PendingDispatchProviderListScreen.pageKey, pageGroup: PageGroup.pendingDispatchProviderListPageKey)
class PendingDispatchProviderListScreen extends BaseScreen {
  static const String pageKey = "OMS_pending_dispatch_provider_list_key";
  static const String route = "/pending_dispatch_provider_list_screen";

  const PendingDispatchProviderListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}
