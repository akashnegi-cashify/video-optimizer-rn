import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(BuildContext context, {bool listen = true}): super(context, listen: listen);

  String get pending => Intl.message('Pending', locale: localName, name: 'pending');

  String get dispatchPending => Intl.message('Dispatch Pending', locale: localName, name: 'dispatchPending');

  String get storeOut => Intl.message('Store Out', locale: localName, name: 'storeOut');

  String get filter => Intl.message('Filter', locale: localName, name: 'filter');

  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');

  String get apply => Intl.message('Apply', locale: localName, name: 'apply');

  String get lotName => Intl.message('Lot Name', locale: localName, name: 'lotName');

  String get invoiceNo => Intl.message('Invoice No', locale: localName, name: 'invoiceNo');

  String get awbNumber => Intl.message('Awb Number', locale: localName, name: 'awbNumber');

  String get scanOtherInvoice => Intl.message('Scan Other Invoice', locale: localName, name: 'scanOtherInvoice');

  String get completeDispatch => Intl.message('Complete Dispatch', locale: localName, name: 'completeDispatch');

}