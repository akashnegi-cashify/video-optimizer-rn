// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);
  String get invoiceDate => Intl.message('Invoice Date', locale: localName, name: 'invoiceDate');
  String get numberOfDevices => Intl.message('Number of devices', locale: localName, name: 'numberOfDevices');
  String get rmName => Intl.message('Rm Name', locale: localName, name: 'rmName');

  String get enterInvoiceNumber => Intl.message('Enter Invoice Number', locale: localName, name: 'enterInvoiceNumber');
  String get submit => Intl.message('Submit', locale: localName, name: 'submit');

  String get success => Intl.message('Success', locale: localName, name: 'success');
  String get ok => Intl.message('Ok', locale: localName, name: 'ok');
  String get selectLotTypeToDisplay => Intl.message('Select Lot Type To Display', locale: localName, name: 'selectLotTypeToDisplay');
  String get clear => Intl.message('Clear', locale: localName, name: 'clear');
  String get apply => Intl.message('Apply', locale: localName, name: 'apply');

  String get scanInvoice => Intl.message('Scan Invoice', locale: localName, name: 'scanInvoice');

  String get lotQty => Intl.message('Lot Qty ', locale: localName, name: 'lotQty');
  String get scannedQty => Intl.message('Scanned Qty ', locale: localName, name: 'scannedQty');
  String get pendingQty => Intl.message('Pending Qty ', locale: localName, name: 'pendingQty');

  String get lotGroupNotEmptyOrNull => Intl.message('Lot Group Name Not Empty Or Null', locale: localName, name: 'lotGroupNotEmptyOrNull');

  String get brand => Intl.message('Brand', locale: localName, name: 'brand');
  String get model => Intl.message('Model', locale: localName, name: 'model');
  String get imei => Intl.message('Imei', locale: localName, name: 'imei');
  String get nothingAvailable => Intl.message('Nothing Available', locale: localName, name: 'nothingAvailable');
  String get scan => Intl.message('Scan', locale: localName, name: 'scan');
  String get scanCode => Intl.message('Scan Code', locale: localName, name: 'scanCode');
  String get enterBarCode => Intl.message('Enter Bar Code', locale: localName, name: 'enterBarCode');
  String get status => Intl.message('Status', locale: localName, name: 'status');
  String get barcode => Intl.message('Barcode', locale: localName, name: 'barcode');


}
