import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/home/providers/home_provider.dart';
import 'package:flutter_trc/src/modules/login/login_screen.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = HomeScreenProviders.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome"),
          const SizedBox(height: Dimens.space_10),
          CshMediumButton(
            text: "Log out",
            onPressed: () {
              _logoutUser(context);
            },
          ),
        ],
      ),
    );
  }

  _logoutUser(BuildContext context) {
    var provider = HomeScreenProviders.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.userLogout().then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        AuthHandler().onSessionExpire();
        Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
      } else {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: "Something went wrong");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
