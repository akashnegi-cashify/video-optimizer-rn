import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get fieldExecutive => Intl.message("Field Executive", locale: localName, name: "fieldExecutive");

  String get receiveDevice => Intl.message("Receive Device", locale: localName, name: "receiveDevice");

  String get barcodeScanner => Intl.message("Barcode Scanner", locale: localName, name: "barcodeScanner");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get productTitle => Intl.message("Product Title", locale: localName, name: "productTitle");

  String get elssEngineerName => Intl.message("Elss Engineer Name", locale: localName, name: "elssEngineerName");

  String get status => Intl.message("Status", locale: localName, name: "status");

  String get repairType => Intl.message("Repair Type", locale: localName, name: "repairType");

  String get repairOrder => Intl.message("Repair Order", locale: localName, name: "repairOrder");

  String get close => Intl.message("Close", locale: localName, name: "close");

  String get searchByName => Intl.message("Search by name", locale: localName, name: "searchByName");

  String get tlName => Intl.message("TL Name", locale: localName, name: "tlName");
}
