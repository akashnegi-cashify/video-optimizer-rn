import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';

import '../l10n.dart';

class ElssStatusScreenArg {
  ElssStatus elssStatus;

  ElssStatusScreenArg({required this.elssStatus});
}

class ElssStatusScreen extends StatelessWidget {

  static String routeName = "/elss-status";

  const ElssStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ElssStatusScreenArg? arg = ModalRoute.of(context)!.settings.arguments as ElssStatusScreenArg?;
    assert(arg != null);
    var l10n = L10n(context);
    ThemeData theme = Theme.of(context);
    var statusData = _getStatusData(arg!.elssStatus, l10n);

    return Scaffold(
      appBar: CshHeader(l10n.elssStatus),
      body: CshCard(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_32, vertical: Dimens.space_30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(statusData.imagePath, height: 100, width: 100),
            const SizedBox(height: Dimens.space_24),
            Text(statusData.description, style: theme.primaryTextTheme.headline2, maxLines: 2),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Dimens.space_24),
        child: CshBigButton(
          text: l10n.done,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
          },
        ),
      ),
    );
  }

  _ElssStatusData _getStatusData(ElssStatus status, L10n l10n) {
    switch (status) {
      case ElssStatus.submit:
        return _ElssStatusData("assets/images/ic_elss_accept.png", l10n.elssSubmitDescription);
      case ElssStatus.reject:
        return _ElssStatusData("assets/images/ic_elss_reject.png", l10n.rejectDescription);
      case ElssStatus.pna:
        return _ElssStatusData("assets/images/ic_pna.png", l10n.pnaDescription);
    }
  }
}

class _ElssStatusData {
  String imagePath;
  String description;

  _ElssStatusData(this.imagePath, this.description);
}
