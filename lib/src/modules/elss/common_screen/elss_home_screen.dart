import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/widget/logout_action_widget.dart';

import '../elss_qc/l10n.dart';
import '../elss_qc/widgets/elss_home_widget.dart';

class ElssHomeScreen extends StatefulWidget {
  static const route = "/elss-home-screen";

  const ElssHomeScreen({Key? key}) : super(key: key);

  @override
  State<ElssHomeScreen> createState() => _ElssHomeScreenState();
}

class _ElssHomeScreenState extends State<ElssHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    bool? arg = ModalRoute.of(context)?.settings.arguments as bool?;

    return Scaffold(
      appBar: CshHeader(
        l10n.elssHome,
        showBackBtn: false,
        actions:  [LogoutActionWidget()],
      ),
      body: ElssHomeWidget(
        isLoginFromQC: arg ?? false,
      ),
    );
  }
}
