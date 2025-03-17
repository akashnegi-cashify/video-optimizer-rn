import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get category => Intl.message("Category", locale: localName, name: "category");

  String get imei => Intl.message("IMEI", locale: localName, name: "imei");

  String get imeiMismatched => Intl.message("Imei Mismatched", locale: localName, name: "imeiMismatched");

  String get serialNoMismatched => Intl.message("Serial No Mismatched", locale: localName, name: "serialNoMismatched");

  String get manualSearch => Intl.message("Manual Search", locale: localName, name: "manualSearch");

  String get search => Intl.message("Search", locale: localName, name: "search");

  String get validateImei => Intl.message("Validate Imei", locale: localName, name: "validateImei");

  String get validateSerial => Intl.message("Validate Serial No", locale: localName, name: "validateSerial");

  String get serialNo => Intl.message("Serial No", locale: localName, name: "serialNo");

  String get imei2 => Intl.message("IMEI 2", locale: localName, name: "imei2");

  String get barcode => Intl.message("Barcode", locale: localName, name: "barcode");

  String get selectCategory => Intl.message("Select Category", locale: localName, name: "selectCategory");

  String get selectBrand => Intl.message("Select Brand", locale: localName, name: "selectBrand");

  String get selectCorrectImei => Intl.message("Select correct Imei", locale: localName, name: "selectCorrectImei");

  String get deviceImei => Intl.message("Device Imei", locale: localName, name: "deviceImei");

  String get deviceSerialNo => Intl.message("Device Serial No", locale: localName, name: "deviceSerialNo");

  String get scannedImei => Intl.message("Scanned Imei", locale: localName, name: "scannedImei");

  String get scannedSerialNo => Intl.message("Scanned Serial No", locale: localName, name: "scannedSerialNo");

  String get reScan => Intl.message("Re Scan", locale: localName, name: "reScan");

  String get reportMismatch => Intl.message("Report Mismatch", locale: localName, name: "reportMismatch");

  String get unableToScan => Intl.message("Unable to Scan", locale: localName, name: "unableToScan");

  String get updateMissingImei => Intl.message("Update Missing IMEI", locale: localName, name: "updateMissingImei");

  String get imeiMismatchDescription => Intl.message("Please capture Image of IMEI to report mismatch", locale: localName, name: "imeiMismatchDescription");

  String get serialMismatchDescription => Intl.message("Please capture Image of Serial No to report mismatch", locale: localName, name: "serialMismatchDescription");

  String get imeiUpdateDescription => Intl.message("Please update the missing IMEI carefully and capture image.", locale: localName, name: "imeiUpdateDescription");

  String get matchedImei => Intl.message("Matched Imei", locale: localName, name: "matchedImei");

  String get imeiNotAvailable => Intl.message("IMEI 2 not available", locale: localName, name: "imeiNotAvailable");

  String get update => Intl.message("Update", locale: localName, name: "update");

  String get brand => Intl.message("Brand", locale: localName, name: "brand");

  String get enterSerialManually => Intl.message("Enter Serial No Manually", locale: localName, name: "enterSerialManually");

  String get updateCategoryIfNeeded =>
      Intl.message("Update Category If needed", locale: localName, name: "updateCategoryIfNeeded");
}
