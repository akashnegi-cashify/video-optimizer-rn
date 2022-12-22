import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get barcodeScanner => Intl.message("Barcode Scanner", locale: localName, name: "barcodeScanner");

  String get enterBarcode => Intl.message("Enter Barcode", locale: localName, name: "enterBarcode");
  String get next => Intl.message("Next", locale: localName, name: "next");
}
