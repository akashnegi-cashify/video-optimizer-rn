import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _lottieAnimationController;

  @override
  void initState() {
    _lottieAnimationController = AnimationController(vsync: this);
    _lottieAnimationController?.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _checkAuth();
      }
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

  void _checkAuth() {
    print('${AuthHandler().userAuth}');
    if (AuthHandler().userAuth == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
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
