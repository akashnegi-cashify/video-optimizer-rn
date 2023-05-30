import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/return_page_provider.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../widgets/receive_tab_widget.dart';
import '../widgets/return_tab_widget.dart';

class ReturnScreen extends StatelessWidget {
  static const String route = "/return_screen";

  const ReturnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<ReturnProvider>(
      create: (_) => ReturnProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CshHeader(
              l10n.returns,
              showBackBtn: true,
              bottom: TabBar(
                labelStyle: theme.primaryTextTheme.headline4,
                labelColor: theme.primaryColor,
                unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
                indicatorWeight: Dimens.space_4,
                indicatorColor: theme.primaryColor,
                tabs: [
                  Tab(text: l10n.receive),
                  Tab(text: l10n.returns),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ReceiveTabWidget(),
                ReturnTabWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
