import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CshHeader("Home"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: "Log Out",
              onPressed: () {
                AuthHandler().onSessionExpire();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
