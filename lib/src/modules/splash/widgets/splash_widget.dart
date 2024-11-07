import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:lottie/lottie.dart';

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

  void _checkAuth(BuildContext context) {
    var loginType = AppPreferences.app.getLoginType();
    var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
    String? userAuth = loginTypeEnum == LoginTypes.qcLogin ? AppPreferences.qc.getUserAuth() : AuthHandler().userAuth;
    if (Validator.isNullOrEmpty(userAuth)) {
      Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
    } else {
      AuthHandler().setUserAuth(userAuth!);
      UserDetails().setUserDetailsData(userAuth);
      UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
          loginType: loginTypeEnum);
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
        repeat: false,
        controller: _lottieAnimationController,
        onLoaded: (LottieComposition composition) {
          playAnimation(composition);
        },
      ),
    );
  }
}
