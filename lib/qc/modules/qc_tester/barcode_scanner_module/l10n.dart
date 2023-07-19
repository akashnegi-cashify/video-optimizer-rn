import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get orEnterManually => Intl.message("Or Enter Manually", locale: localName, name: "orEnterManually");

  String get enterBarcode => Intl.message("Enter Barcode", locale: localName, name: "enterBarcode");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get barcodeScanner => Intl.message("Barcode Scanner", locale: localName, name: "barcodeScanner");

  String get assignBarcode => Intl.message("Assign Barcode", locale: localName, name: "assignBarcode");
}
