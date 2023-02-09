import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/part_selection_screen_trc.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';
import '../../../../screens/barcode_scanner_screen.dart';
import '../l10n.dart';
import '../../common_providers/user_session_provider.dart';

class ELSSScreenTrc extends StatelessWidget {
  static const route = '/elss_screen_trc';

  const ELSSScreenTrc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<UserSessionProvider>(
      create: (_) => UserSessionProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Scaffold(
          appBar: CshHeader(l10n.elss, showBackBtn: true),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: Dimens.space_1),
                SizedBox(
                  width: double.infinity,
                  child: CshMediumButton(
                    text: l10n.scanBarcode,
                    onPressed: () {
                      Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                        if (!Validator.isNullOrEmpty(data)) {
                          Navigator.of(context)
                              .pushReplacementNamed(PartSelectionScreenTrc.route, arguments: data.trim());
                        }
                      });
                    },
                  ),
                ),
                _userDetailsWidget(theme, l10n, UserDetails().userDetailsData?.userName ?? "", "1.0.0")
              ],
            ),
          ),
        );
      },
    );
  }

  _userDetailsWidget(ThemeData theme, L10n l10n, String? userName, String appVersion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!Validator.isNullOrEmpty(userName))
          Text(
            "${l10n.loggedInUser}: ${userName!}",
            style: theme.primaryTextTheme.headline3,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        if (!Validator.isNullOrEmpty(appVersion)) ...[
          const SizedBox(height: Dimens.space_14),
          Text(
            "${l10n.appVersion}: $appVersion",
            style: theme.primaryTextTheme.headline3,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ]
      ],
    );
  }
}
