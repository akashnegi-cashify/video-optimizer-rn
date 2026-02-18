// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get storeIn => Intl.message('Store In', locale: localName, name: 'storeIn');

  String get selectStorageType => Intl.message('Select Storage Type', locale: localName, name: 'selectStorageType');

  String get binStorage => Intl.message('Bin Storage', locale: localName, name: 'binStorage');

  String get goBack => Intl.message('Go Back', locale: localName, name: 'goBack');

  String get scanDevice => Intl.message('Scan Device', locale: localName, name: 'scanDevice');

  String get scanOther => Intl.message('Scan Other', locale: localName, name: 'scanOther');

  String get stockBarcode => Intl.message('Stock Barcode : ', locale: localName, name: 'stockBarcode');

  String get locationBarcode => Intl.message('Location Barcode : ', locale: localName, name: 'locationBarcode');

  String get trayBarcode => Intl.message('Tray barcode:- ', locale: localName, name: 'trayBarcode');

  String get totalSpace => Intl.message('Total Space:- ', locale: localName, name: 'totalSpace');

  String get availableSpace =>
      Intl.message('Available Space:- ', locale: localName, name: 'availableSpace');

  String get retry => Intl.message('Retry', locale: localName, name: 'retry');

  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');

  String get scanCancelled => Intl.message('Scan Cancelled', locale: localName, name: 'scanCancelled');

  String get warning => Intl.message('Warning', locale: localName, name: 'warning');

  String get scanDeviceCamelCase => Intl.message('Scan Device', locale: localName, name: 'scanDeviceCamelCase');

  String get scanBinLocationQrCode => Intl.message('Scan Bin location Qr Code', locale: localName, name: 'scanBinLocationQrCode');

  String get scanLocationQrCode => Intl.message('Scan location Qr Code', locale: localName, name: 'scanLocationQrCode');

  String get change => Intl.message('Change', locale: localName, name: 'change');

  String get scan => Intl.message('Scan', locale: localName, name: 'scan');

  String get storageType => Intl.message('Storage Type', locale: localName, name: 'storageType');

  String get spaceIsFull => Intl.message('Space is full', locale: localName, name: 'spaceIsFull');

  String get save => Intl.message('Save', locale: localName, name: 'save');

  String get doYouWantToChangeLocation => Intl.message('Do you want to scan another location?', locale: localName, name: 'doYouWantToChangeLocation');
}
