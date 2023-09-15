import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get enterAwbImeiBarcodeNumber => Intl.message("Enter Awb IMEI number or Barcode", locale: localName, name: "enterAwbImeiBarcodeNumber");

}
