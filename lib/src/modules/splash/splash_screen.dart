import 'dart:async';

import 'package:components/components.dart';
import 'package:console_flutter_template/src/modules/login/screen/login_screen.dart';
import 'package:console_flutter_template/src/screens/home_screen.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../pd/pd_screen_example.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      _checkAuth();
    });
    super.initState();
  }

  void _checkAuth() {
    Logger.debug('_SplashScreenState._checkAuth', [AuthHandler().userAuth]);
    if (AuthHandler().userAuth == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    BaseL10n l10n = BaseL10n(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
      ),
      body: const Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
