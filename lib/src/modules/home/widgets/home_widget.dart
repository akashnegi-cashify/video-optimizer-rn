import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/home/providers/home_provider.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome"),
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
        AppPreferences().resetAndClearAll();
        Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
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
