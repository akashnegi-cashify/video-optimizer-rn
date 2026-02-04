// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get enterAwbNumber => Intl.message('Enter AWB Number', locale: localName, name: 'enterAwbNumber');
  String get enterInternalBarcode => Intl.message('Enter Internal Barcode', locale: localName, name: 'enterInternalBarcode');

  String get awbNo => Intl.message('Awb No.', locale: localName, name: 'awbNo');
  String get internalBarcode => Intl.message('Internal Barcode', locale: localName, name: 'internalBarcode');
  String get submit => Intl.message('Submit', locale: localName, name: 'submit');

  String get brand => Intl.message('Brand', locale: localName, name: 'brand');
  String get sourceName => Intl.message('Source Name', locale: localName, name: 'sourceName');
  String get product => Intl.message('Product', locale: localName, name: 'product');
  String get imei1 => Intl.message('Imei 1', locale: localName, name: 'imei1');
  String get imei2 => Intl.message('Imei 2', locale: localName, name: 'imei2');
  String get done => Intl.message('Done', locale: localName, name: 'done');
  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');
  String get pleaseUploadAllMediaFiles => Intl.message('Please Upload All Media Files', locale: localName, name: 'pleaseUploadAllMediaFiles');

  String get alert => Intl.message('Alert', locale: localName, name: 'alert');
  String get allProgressWillBeLost => Intl.message('All Progress Will Be Lost.', locale: localName, name: 'allProgressWillBeLost');
  String get exit => Intl.message('EXIT', locale: localName, name: 'exit');
  String get capCancel => Intl.message('CANCEL', locale: localName, name: 'capCancel');
  String get ok => Intl.message('Ok', locale: localName, name: 'ok');
  String get retry => Intl.message('Retry', locale: localName, name: 'retry');

  String get pleaseEnterAwbNumber => Intl.message('Please enter awb number.', locale: localName, name: 'pleaseEnterAwbNumber');
  String get pleaseEnterInternalBarcode => Intl.message('Please enter internal barcode', locale: localName, name: 'pleaseEnterInternalBarcode');
  String get error => Intl.message('Error', locale: localName, name: 'error');
  String get warning => Intl.message('Warning', locale: localName, name: 'warning');
}