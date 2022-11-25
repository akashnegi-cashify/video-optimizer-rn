import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get login => Intl.message("Login", locale: localName, name: "login");

  String get pleaseEnterYourEmployeeId =>
      Intl.message("Please enter your employee id", locale: localName, name: "pleaseEnterYourEmployeeId");

  String get continueStr => Intl.message("Continue", locale: localName, name: "continueStr");

  String get techRefurbishCenter =>
      Intl.message("Tech Refurbish Center", locale: localName, name: "techRefurbishCenter");

  String get employeeId => Intl.message("Employee Id", locale: localName, name: "employeeId");

  String get password => Intl.message("Password", locale: localName, name: "password");

  String get location => Intl.message("Location", locale: localName, name: "location");

  String get verify => Intl.message("Verify", locale: localName, name: "verify");
}
