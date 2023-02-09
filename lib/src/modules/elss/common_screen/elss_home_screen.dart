import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import '../../login/login_screen.dart';
import '../common_providers/user_session_provider.dart';
import '../elss_qc/l10n.dart';
import '../elss_qc/widgets/elss_home_widget.dart';
import '../widgets/logout_modal_widget.dart';

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

    return ChangeNotifierProvider<UserSessionProvider>(
      create: (_) => UserSessionProvider(),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.elssHome,
            showBackBtn: false,
            actions: [
              GestureDetector(
                onTap: () {
                  _onModuleLogout(innerContext);
                },
                child: CshIcon(
                  FeatherIcons.logOut,
                  iconSize: MobileIconSize.medium,
                  padding: EdgeInsets.zero,
                  iconColor: theme.primaryColor,
                ),
              )
            ],
          ),
          body: ElssHomeWidget(
            isLoginFromQC: arg ?? false,
          ),
        );
      },
    );
  }

  _onLogoutMethod(BuildContext insideContext) {
    var provider = UserSessionProvider.of(insideContext, listen: false);
    CshLoading().showLoading(context);
    provider.logoutUserAndClearSession().then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        _successLogout();
        CshSnackBar.success(context: context, message: "Logged Out Successfully");
      } else {
        CshSnackBar.error(context: context, message: "Something Went Wrong!!!");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _onModuleLogout(BuildContext insideContext) {
    showCshBottomSheet(
      context: insideContext,
      child: LogoutModalWidget(
        onLogoutCallback: () {
          _onLogoutMethod(insideContext);
        },
      ),
    );
  }

  _successLogout() async {
    await AuthHandler().onSessionExpire();
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
  }
}
