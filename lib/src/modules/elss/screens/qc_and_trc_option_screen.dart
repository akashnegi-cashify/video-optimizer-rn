import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/providers/user_session_provider.dart';
import 'package:flutter_trc/src/modules/elss/screens/elss_screen.dart';
import 'package:provider/provider.dart';
import '../../login/login_screen.dart';
import '../l10n.dart';
import '../widgets/logout_modal_widget.dart';

class QcAndTRCOptionScreen extends StatelessWidget {
  static const String route = '/qc-and-trc-option-screen';

  const QcAndTRCOptionScreen({Key? key}) : super(key: key);

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
            l10n.techRefurbishmentCenter,
            showBackBtn: false,
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
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CshMediumButton(
                      text: l10n.qc,
                      onPressed: () {
                        Navigator.of(context).pushNamed(ELSSScreen.route);
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.space_60),
                  SizedBox(
                    width: double.infinity,
                    child: CshMediumButton(
                      text: l10n.trc,
                      onPressed: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
