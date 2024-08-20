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

  String get pleaseEnterPassword =>
      Intl.message("Please enter password", locale: localName, name: "pleaseEnterPassword");

  String get loggedInSuccessfully =>
      Intl.message("Logged in successfully", locale: localName, name: "loggedInSuccessfully");

  String get somethingWentWrong => Intl.message("Something went wrong", locale: localName, name: "somethingWentWrong");

  String get qcLogin => Intl.message("QC Login", locale: localName, name: "qcLogin");

  String get trcLogin => Intl.message("TRC Login", locale: localName, name: "trcLogin");

  String get pleaseEnterYourMobileNumber =>
      Intl.message("Please enter your mobile number", locale: localName, name: "pleaseEnterYourMobileNumber");

  String get mobileNumber => Intl.message("Mobile Number", locale: localName, name: "mobileNumber");

  String get enterOtp => Intl.message("Enter OTP", locale: localName, name: "enterOtp");

  String get verifyOtp => Intl.message("Verify OTP", locale: localName, name: "verifyOtp");

  String get otpSentSuccessfully =>
      Intl.message("OTP Sent Successfully!!", locale: localName, name: "otpSentSuccessfully");

  String get pleaseEnterMobileNumber =>
      Intl.message("Please Enter Mobile Number!!", locale: localName, name: "pleaseEnterMobileNumber");

  String get pleaseEnterCredentials =>
      Intl.message("Please enter company name and mobile number!!", locale: localName, name: "pleaseEnterCredentials");

  String get pleaseEnterOtpSentToNumber =>
      Intl.message("Please Enter OTP Sent To Number!!", locale: localName, name: "pleaseEnterOtpSentToNumber");

  String get changeNo => Intl.message("Change No.", locale: localName, name: "changeNo");

  String get resendOtp => Intl.message("Resend OTP", locale: localName, name: "resendOtp");

  String get changePassword => Intl.message("Change Password", locale: localName, name: "changePassword");

  String get shipexLogin => Intl.message("Shipex Login", locale: localName, name: "shipexLogin");

  String get rmsLogin => Intl.message("RMS Login", locale: localName, name: "rmsLogin");
}
