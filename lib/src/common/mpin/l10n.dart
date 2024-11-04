import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get deviceDeadRepair => Intl.message('Device Dead/Repair', locale: localName, name: 'deviceDeadRepair');

  String get setMPin => Intl.message('SET MPIN', locale: localName, name: 'setMPin');

  String get mPinDesc => Intl.message('Enter a unique 6-digit numeric MPIN to secure your account', locale: localName, name: 'mPinDesc');

  String get enterMPin => Intl.message('Enter MPIN', locale: localName, name: 'enterMPin');

  String get consecutiveNumberDesc => Intl.message('No consecutive numbers (eg. 123456).', locale: localName, name: 'consecutiveNumberDesc');

  String get repetitiveNumberDesc => Intl.message('No repeating digits (eg. 111111).', locale: localName, name: 'repetitiveNumberDesc');

  String get confirmMPin => Intl.message('Confirm MPIN', locale: localName, name: 'confirmMPin');

}
