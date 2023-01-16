import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get scanBarcode => Intl.message("Scan Barcode", locale: localName, name: "scanBarcode");

  String get receivedDevice => Intl.message("Received Device", locale: localName, name: "receivedDevice");

  String get loggedInUser => Intl.message("Logged In User", locale: localName, name: "loggedInUser");

  String get appVersion => Intl.message("App Version", locale: localName, name: "appVersion");

  String get home => Intl.message("Home", locale: localName, name: "home");

  String get somethingWentWrong => Intl.message("Something went wrong!", locale: localName, name: "somethingWentWrong");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get deviceName => Intl.message("Device Name", locale: localName, name: "deviceName");

  String get deviceId => Intl.message("Device Id", locale: localName, name: "deviceId");

  String get rubbingNotDone => Intl.message("Rubbing Not Done", locale: localName, name: "rubbingNotDone");

  String get rubbingDone => Intl.message("Rubbing Done", locale: localName, name: "rubbingDone");

  String get deviceRemovedFromRubbing =>
      Intl.message("Device Removed From Rubbing!", locale: localName, name: "deviceRemovedFromRubbing");

  String get deviceReceivedSuccessfully =>
      Intl.message("Device Received successfully", locale: localName, name: "deviceReceivedSuccessfully");

  String get searchBarCode => Intl.message("Search Barcode", locale: localName, name: "searchBarCode");
}
