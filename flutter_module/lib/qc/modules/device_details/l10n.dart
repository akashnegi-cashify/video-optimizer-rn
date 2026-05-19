// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get barcode => Intl.message("Barcode", locale: localName, name: "barcode");

  String get retry => Intl.message("Retry", locale: localName, name: "retry");

  String get model => Intl.message("Model", locale: localName, name: "model");

  String get imei1 => Intl.message("Imei1", locale: localName, name: "imei1");

  String get imei2 => Intl.message("Imei2", locale: localName, name: "imei2");

  String get serialNo => Intl.message("Serial No", locale: localName, name: "serialNo");
  
  String get location => Intl.message("Location", locale: localName, name: "location");

  String get currentStatus => Intl.message("Current Status", locale: localName, name: "currentStatus");

  String get repairStatus => Intl.message("Repair Status", locale: localName, name: "repairStatus");

  String get stockAge => Intl.message("Stock Age", locale: localName, name: "stockAge");

  String get lotName => Intl.message("Lot Name", locale: localName, name: "lotName");

  String get otexSource => Intl.message("Otex Source", locale: localName, name: "otexSource");

  String get channelName => Intl.message("Channel Name", locale: localName, name: "channelName");

  String get scanOtherDevice => Intl.message("Scan Other Device", locale: localName, name: "scanOtherDevice");

  String get stockMovement => Intl.message("Stock Movement", locale: localName, name: "stockMovement");
}
