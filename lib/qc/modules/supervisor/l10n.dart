// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(BuildContext context, {bool listen = true}) : super(context, listen: listen);

  String get verifyDeviceDetails =>
      Intl.message('Verify Device Details', locale: localName, name: 'verifyDeviceDetails');

  String get deviceBarcode => Intl.message('Device Barcode', locale: localName, name: 'deviceBarcode');

  String get deviceStatus => Intl.message('Device Status', locale: localName, name: 'deviceStatus');

  String get manualTestDetails => Intl.message('Manual Test Details', locale: localName, name: 'manualTestDetails');

  String get manualTestBy => Intl.message('Manual Test by', locale: localName, name: 'manualTestBy');

  String get manualTestOn => Intl.message('Manual Test On', locale: localName, name: 'manualTestOn');

  String get cdpTestedBy => Intl.message('CDP Tested by', locale: localName, name: 'cdpTestedBy');

  String get cdpTestedOn => Intl.message('CDP Test On', locale: localName, name: 'cdpTestedOn');

  String get startSupervision => Intl.message('Start Supervision', locale: localName, name: 'startSupervision');

  String get viewDeviceImages => Intl.message('View Device Images', locale: localName, name: 'viewDeviceImages');

  String get markFail => Intl.message('Mark Fail', locale: localName, name: 'markFail');

  String get pass => Intl.message('Pass', locale: localName, name: 'pass');

  String get category => Intl.message('Category', locale: localName, name: 'category');

  String get added => Intl.message('Added', locale: localName, name: 'added');

  String get select => Intl.message('Select', locale: localName, name: 'select');

  String get supervisionSuccessMessage => Intl.message('You have successfully completed the Supervision.',
      locale: localName, name: 'supervisionSuccessMessage');

}
