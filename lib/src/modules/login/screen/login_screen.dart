import 'package:components/auth/types.dart';
import 'package:components/components.dart';
import 'package:console_flutter_template/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginView(
      isSelected: false,
      isShowedTNCCheckbox: false,
      template: 'legal_app',
      tncPageTitle: 'TNC',
      termsAndConditionUrl: null,
      onSubmit: (String? value, LoginMode mode, mobileNo, pin) {
        AuthHandler().setUserAuth(value ?? '');
        Navigator.of(context).popAndPushNamed(HomeScreen.route);
      },
      serviceName: 'customer',
      serviceVersion: 'v1',
    );
  }
}
