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


}
