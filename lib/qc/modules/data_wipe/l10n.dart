import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen = true});

  String get barcode => Intl.message('Barcode', name: 'barcode');

  String get dataWipe => Intl.message('Data Wipe', name: 'dataWipe');

  String get dataWipeList => Intl.message('Data Wipe List', name: 'dataWipeList');

  String get erasureProvider => Intl.message('Erasure Provider', name: 'erasureProvider');

  String get initiateDataWipe => Intl.message('Initiate Data Wipe', name: 'initiateDataWipe');

  String get scanAnother => Intl.message('Scan Another', name: 'scanAnother');

  String get updateImei => Intl.message('Update IMEI', name: 'updateImei');

  String get updateSerial => Intl.message('Update Serial No', name: 'updateSerial');

  String get scanned => Intl.message('Scanned', name: 'scanned');

  String get goBack => Intl.message('Go Back', name: 'goBack');

  String get filters => Intl.message('Filters', name: 'filters');

  String get initiateBulk => Intl.message('Initiate Bulk', name: 'initiateBulk');

  String get sreYouSure => Intl.message('Are you sure?', name: 'sreYouSure');

  String get proceed => Intl.message('Proceed', name: 'proceed');

  String get serialNumberMatched => Intl.message('Serial Number Matched', name: 'serialNumberMatched');

  String get imeiMatched => Intl.message('Imei Matched', name: 'imeiMatched');

  String get imeiMismatched => Intl.message('Imei Mismatched', name: 'imeiMismatched');

  String get serialNo => Intl.message('Serial No', name: 'serialNo');

  String get serialNumberMismatched => Intl.message('Serial Number Mismatched', name: 'serialNumberMismatched');

  String get proceedToRetryDatawipe => Intl.message('Proceed to Retry Datawipe', name: 'proceedToRetryDatawipe');

  String get report => Intl.message('Report', name: 'report');

  String get retry => Intl.message('Retry', name: 'retry');

  String get imei1 => Intl.message('Imei 1', name: 'imei1');

  String get imei2 => Intl.message('Imei 2', name: 'imei2');

  String get submit => Intl.message('Submit', name: 'submit');

  String get selectAction => Intl.message('Select Action', name: 'selectAction');

  String get unableToScan => Intl.message('Unable to scan', name: 'unableToScan');

  String get enterManually => Intl.message('Enter Manually', name: 'enterManually');

  String get enterImei => Intl.message('Enter Imei', name: 'enterImei');

  String get enterSerialNo => Intl.message('Enter Serial no', name: 'enterSerialNo');

  String erasedDesc(String status) {
    return Intl.message("Initiate Bulk Erase on $status status", name: 'erasedDesc', args: [status]);
  }
}
