import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:lottie/lottie.dart';

import '../../../libraries/shared_prefrences/app_prefrences.dart';
import '../../../resources/user_details.dart';
import '../../login/resources/collector_user_controller.dart';
import '../../login/screens/trc_and_qc_login_screen.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> with SingleTickerProviderStateMixin {
  AnimationController? _lottieAnimationController;

  @override
  void initState() {
    scheduleMicrotask(() {
      _lottieAnimationController = AnimationController(vsync: this);
      _lottieAnimationController?.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            _checkAuth(context);
          }
        }
      });
    });

    super.initState();
  }

  void playAnimation(LottieComposition composition) {
    if (_lottieAnimationController != null) {
      _lottieAnimationController!
        ..duration = composition.duration
        ..forward();
    }
  }

  void _checkAuth(BuildContext context) async {
    if (AuthHandler().userAuth == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
    } else {
      UserDetails().setUserDetailsData(AuthHandler().userAuth!);

      var loginType = await AppPreferences().getLoginType();
      var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");

      await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
          loginToken: AuthHandler().userAuth!, loginType: loginTypeEnum);
      // if (loginTypeEnum == LoginTypes.qcLogin) {
      //   await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
      //       loginToken: AuthHandler().userAuth!, loginType: LoginTypes.qcLogin);
      // } else if (loginTypeEnum == LoginTypes.shipexLogin) {
      //   await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
      //       loginToken: AuthHandler().userAuth!, loginType: LoginTypes.shipexLogin);
      // } else if (loginTypeEnum == LoginTypes.trcLogin){
      //   await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
      //       loginToken: AuthHandler().userAuth!, loginType: LoginTypes.trcLogin);
      // } else {
      //
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset(
        'assets/json/cashify_splash.json',
        frameRate: FrameRate.composition,
        controller: _lottieAnimationController,
        onLoaded: (LottieComposition composition) {
          playAnimation(composition);
        },
      ),
    );
  }
}
