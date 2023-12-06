import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get storeIn => Intl.message('Store In', locale: localName, name: 'storeIn');

  String get binStoreIn => Intl.message('Bin Store In', locale: localName, name: 'binStoreIn');

  String get goBack => Intl.message('GO BACK', locale: localName, name: 'goBack');

  String get scanDevice => Intl.message('SCAN DEVICE', locale: localName, name: 'scanDevice');

  String get scanOther => Intl.message('Scan Other', locale: localName, name: 'scanOther');

  String get binIn => Intl.message('Bin In', locale: localName, name: 'binIn');

  String get stockBarcode => Intl.message('Stock Barcode : ', locale: localName, name: 'stockBarcode');

  String get locationBarcode => Intl.message('Location Barcode : ', locale: localName, name: 'locationBarcode');

  String get trayBarcode => Intl.message('Tray barcode:- ', locale: localName, name: 'trayBarcode');

  String get totalSpace => Intl.message('Total Space:- ', locale: localName, name: 'totalSpace');

  String get totalAvailableSpace =>
      Intl.message('Total Available Space:- ', locale: localName, name: 'totalAvailableSpace');

  String get retry => Intl.message('Retry', locale: localName, name: 'retry');

  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');

  String get scanCancelled => Intl.message('Scan Cancelled', locale: localName, name: 'scanCancelled');

  String get warning => Intl.message('Warning', locale: localName, name: 'warning');

  String get scanDeviceCamelCase => Intl.message('Scan Device', locale: localName, name: 'scanDeviceCamelCase');
}
