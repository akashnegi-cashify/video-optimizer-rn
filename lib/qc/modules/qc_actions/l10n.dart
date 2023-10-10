import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get elss => Intl.message("ELSS", locale: localName, name: "elss");

  String get qcTester => Intl.message("QC Tester", locale: localName, name: "qcTester");

  String get externalAudit => Intl.message("External Audit", locale: localName, name: "externalAudit");

  String get stockIn => Intl.message('Stock In', locale: localName, name: 'stockIn');

  String get dispatch => Intl.message('Dispatch', locale: localName, name: 'dispatch');

  String get reQc => Intl.message("RE-QC SS", locale: localName, name: "reQc");

  String get preDispatch => Intl.message('Pre Dispatch', locale: localName, name: 'preDispatch');

  String get storeIn => Intl.message('Store In', locale: localName, name: 'storeIn');
}
