// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get deviceDetails => Intl.message('Device Details', locale: localName, name: 'deviceDetails');

  String get awbNumber => Intl.message('Awb Number', locale: localName, name: 'awbNumber');

  String get imei1 => Intl.message('IMEI 1', locale: localName, name: 'imei1');

  String get imei2 => Intl.message('IMEI 2', locale: localName, name: 'imei2');

  String get imei1Matched => Intl.message('IMEI 1 Matched', locale: localName, name: 'imei1Matched');

  String get imei1Mismatched => Intl.message('IMEI 1 mismatched', locale: localName, name: 'imei1Mismatched');

  String get imei2Matched => Intl.message('IMEI 2 Matched', locale: localName, name: 'imei2Matched');

  String get imei2Mismatched => Intl.message('IMEI 2 mismatched', locale: localName, name: 'imei2Mismatched');

  String get scannedImei => Intl.message('Scanned IMEI', locale: localName, name: 'scannedImei');

  String get scanImei => Intl.message('Scan IMEI', locale: localName, name: 'scanImei');

  String get reScan => Intl.message('Re Scan', locale: localName, name: 'reScan');

  String get completeValidation => Intl.message('Complete Validation', locale: localName, name: 'completeValidation');
}
