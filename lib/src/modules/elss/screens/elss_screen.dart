import 'package:components/auth/handler/auth_handler.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/screens/part_selection_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';
import '../../../screens/barcode_scanner_screen.dart';
import '../../login/login_screen.dart';
import '../l10n.dart';
import '../providers/user_session_provider.dart';
import '../widgets/logout_modal_widget.dart';

class ELSSScreen extends StatelessWidget {
  static const route = '/elss_screen';

  const ELSSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<UserSessionProvider>(
      create: (_) => UserSessionProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.elss,
            actions: [
              GestureDetector(
                onTap: () {
                  _applicationLogout(insideContext);
                },
                child: CshIcon(
                  FeatherIcons.logOut,
                  iconSize: MobileIconSize.medium,
                  padding: EdgeInsets.zero,
                  iconColor: theme.primaryColor,
                ),
              ),
            ],
          ),
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
                          Navigator.of(context).pushReplacementNamed(PartSelectionScreen.route, arguments: data.trim());
                        }
                      });
                    },
                  ),
                ),
                _userDetailsWidget(theme, l10n, UserDetails().userDetailsData?.userName ?? "", "")
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
            "${l10n.appVersion}: ${appVersion}",
            style: theme.primaryTextTheme.headline3,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ]
      ],
    );
  }

  _applicationLogout(BuildContext context) {
    showCshBottomSheet(
        context: context,
        child: LogoutModalWidget(
          onLogoutCallback: () {
            _onLogout(context);
          },
        ));
  }

  _onLogout(BuildContext context) {
    var provider = UserSessionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession().then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        AuthHandler().onSessionExpire();
        Logger.debug('mydebug------ELSSScreen._onLogout', [AuthHandler().userAuth]);
        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
