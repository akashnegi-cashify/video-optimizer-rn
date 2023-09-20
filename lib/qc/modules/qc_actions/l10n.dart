import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get elss => Intl.message("ELSS", locale: localName, name: "elss");

  String get qcTester => Intl.message("QC Tester", locale: localName, name: "qcTester");

  String get externalAudit => Intl.message("External Audit", locale: localName, name: "externalAudit");
}
