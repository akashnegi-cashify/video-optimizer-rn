import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/user_details.dart';
import '../../utils/trc_method_channels.dart';
import '../login/login_screen.dart';
import '../login/resources/collector_user_controller.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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
      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
    } else {
      UserDetails().setUserDetailsData(AuthHandler().userAuth!);

      await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
          loginToken: AuthHandler().userAuth!);
      if (mounted) {
        await NativeCall.registerLogout(context);
      }
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
