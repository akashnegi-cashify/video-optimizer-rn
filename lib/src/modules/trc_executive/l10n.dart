// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get fieldExecutive => Intl.message("Field Executive", locale: localName, name: "fieldExecutive");

  String get receiveDevice => Intl.message("Receive Device", locale: localName, name: "receiveDevice");

  String get barcodeScanner => Intl.message("Barcode Scanner", locale: localName, name: "barcodeScanner");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get device => Intl.message("Device", locale: localName, name: "device");

  String get rubbingOrGlassChange => Intl.message("Rubbing/Glass Change", locale: localName, name: "rubbingOrGlassChange");

  String get productTitle => Intl.message("Product", locale: localName, name: "productTitle");

  String get elssEngineerName => Intl.message("Elss Engineer Name", locale: localName, name: "elssEngineerName");

  String get status => Intl.message("Status", locale: localName, name: "status");

  String get repairType => Intl.message("Repair Type", locale: localName, name: "repairType");

  String get repairOrder => Intl.message("Repair Order", locale: localName, name: "repairOrder");

  String get close => Intl.message("Close", locale: localName, name: "close");

  String get searchByName => Intl.message("Search by name", locale: localName, name: "searchByName");

  String get tlName => Intl.message("TL Name", locale: localName, name: "tlName");

  String get storage => Intl.message("Storage", locale: localName, name: "storage");

  String get changeStorage => Intl.message("Change Storage", locale: localName, name: "changeStorage");

  String get storeIn => Intl.message("Store In", locale: localName, name: "storeIn");

  String get storeOut => Intl.message("Store Out", locale: localName, name: "storeOut");

  String get totalSpace => Intl.message("Total Space", locale: localName, name: "totalSpace");

  String get availableSpace => Intl.message("Available Space", locale: localName, name: "availableSpace");

  String get scanStorageBarcode => Intl.message("Scan Storage Barcode", locale: localName, name: "scanStorageBarcode");

  String get scanDeviceBarcode => Intl.message("Scan Device Barcode", locale: localName, name: "scanDeviceBarcode");

  String get barcode => Intl.message("Barcode", locale: localName, name: "barcode");

  String get location => Intl.message("Location", locale: localName, name: "location");

  String get allDevicesCompleted =>
      Intl.message("All devices completed", locale: localName, name: "allDevicesCompleted");

  String get storeOutCompleted =>
      Intl.message("Store out completed", locale: localName, name: "storeOutCompleted");

  String get scannedBarcodeDoesNotMatch =>
      Intl.message("Scanned barcode does not match expected device", locale: localName, name: "scannedBarcodeDoesNotMatch");
}
