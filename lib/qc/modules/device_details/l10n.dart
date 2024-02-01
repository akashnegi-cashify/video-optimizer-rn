import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get retry => Intl.message("Retry", locale: localName, name: "retry");

  String get model => Intl.message("Model", locale: localName, name: "model");

  String get imei => Intl.message("Imei", locale: localName, name: "imei");

  String get serialNo => Intl.message("Serial No", locale: localName, name: "serialNo");

  String get storageLocation => Intl.message("Storage Location", locale: localName, name: "storageLocation");

  String get currentStatus => Intl.message("Current Status", locale: localName, name: "currentStatus");

  String get repairStatus => Intl.message("Repair Status", locale: localName, name: "repairStatus");

  String get stockAge => Intl.message("Stock Age", locale: localName, name: "stockAge");

  String get lotName => Intl.message("Lot Name", locale: localName, name: "lotName");

  String get channelName => Intl.message("Channel Name", locale: localName, name: "channelName");

  String get scanOtherDevice => Intl.message("Scan Other Device", locale: localName, name: "scanOtherDevice");
}
