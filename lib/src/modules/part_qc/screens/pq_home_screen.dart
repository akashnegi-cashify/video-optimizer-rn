import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/providers/pq_provider.dart';
import 'package:provider/provider.dart';
import '../../../common/user/widget/logout_action_widget.dart';
import '../l10n.dart';
import '../widgets/qc_pending_tab_widget.dart';
import '../widgets/reader_tab_widget.dart';

class PartQCHomeScreen extends StatelessWidget {
  static const String route = "/part_qc_home_screen";

  const PartQCHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<PartQcProvider>(
      create: (_) => PartQcProvider(),
      lazy: false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CshHeader(
            l10n.partQc,
            showBackBtn: false,
            actions: [LogoutActionWidget()],
            bottom: TabBar(
              labelStyle: theme.primaryTextTheme.headline4,
              labelColor: theme.primaryColor,
              unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
              unselectedLabelColor: theme.primaryColor,
              indicatorColor: theme.primaryColor,
              indicatorWeight: Dimens.space_5,
              tabs: [
                Tab(text: l10n.reader.toUpperCase()),
                Tab(text: l10n.qcPending.toUpperCase()),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ReaderTabWidget(),
              QcPendingTabWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
