import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen = true});

  String get deviceDeadRepair => Intl.message('Device Dead/Repair', locale: localName, name: 'deviceDeadRepair');

  String get setMPin => Intl.message('SET MPIN', locale: localName, name: 'setMPin');

  String get mPinDesc =>
      Intl.message('Enter a unique 6-digit numeric MPIN to secure your account', locale: localName, name: 'mPinDesc');

  String get enterMPin => Intl.message('Enter MPIN', locale: localName, name: 'enterMPin');

  String get consecutiveNumberDesc =>
      Intl.message('No consecutive numbers (eg. 123456).', locale: localName, name: 'consecutiveNumberDesc');

  String get repetitiveNumberDesc =>
      Intl.message('No repeating digits (eg. 111111).', locale: localName, name: 'repetitiveNumberDesc');

  String get confirmMPin => Intl.message('Confirm MPIN', locale: localName, name: 'confirmMPin');

  String get fingerprintNotEnabled =>
      Intl.message('Fingerprint not enabled', locale: localName, name: 'fingerprintNotEnabled');

  String get fingerprintNotEnabledDesc =>
      Intl.message('Please enable lockscreen security and Fingerprint authentication in settings',
          locale: localName, name: 'fingerprintNotEnabledDesc');

  String get enableSetting => Intl.message('Enable Settings', locale: localName, name: 'enableSetting');

  String get enableFingerprint => Intl.message('Enable Fingerprint', locale: localName, name: 'enableFingerprint');

  String get enableFingerprintDesc => Intl.message('With Touch ID, you won’t need to enter your mPIN every time.',
      locale: localName, name: 'enableFingerprintDesc');

  String get enable => Intl.message('Enable', locale: localName, name: 'enable');

  String get enterSixDigitPin => Intl.message('Please Enter 6 digit MPIN', locale: localName, name: 'enterSixDigitPin');

  String get forgetMPin => Intl.message('Forgot MPIN', locale: localName, name: 'forgetMPin');

  String get changeUser => Intl.message('Change User', locale: localName, name: 'changeUser');

  String get submit => Intl.message('Submit', locale: localName, name: 'submit');

  String get loginUsingFingerprint =>
      Intl.message('Login Using Fingerprint', locale: localName, name: 'loginUsingFingerprint');

  String get registrationSuccessful =>
      Intl.message('Registration successful', locale: localName, name: 'registrationSuccessful');

  String get login => Intl.message('Login', locale: localName, name: 'login');

  String get switchModule => Intl.message('Switch Module', locale: localName, name: 'switchModule');
}
