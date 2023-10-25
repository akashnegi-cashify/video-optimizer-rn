import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get receive => Intl.message("Receive", locale: localName, name: "receive");

  String get deliver => Intl.message("Deliver", locale: localName, name: "deliver");

  String get search => Intl.message("Search", locale: localName, name: "search");

  String get searchBarcode => Intl.message("Search Barcode", locale: localName, name: "searchBarcode");

  String get showUrgentRequestsOnly =>
      Intl.message("Show Urgent Requests Only", locale: localName, name: "showUrgentRequestsOnly");

  String get somethingWentWrong => Intl.message("Something went wrong", locale: localName, name: "somethingWentWrong");

  String get engineersName => Intl.message("Engineer's Name", locale: localName, name: "engineersName");

  String get engineerParts => Intl.message("Engineer Parts", locale: localName, name: "engineerParts");

  String get location => Intl.message("Location", locale: localName, name: "location");

  String get partName => Intl.message("Part Name", locale: localName, name: "partName");

  String get partBarcode => Intl.message("Part Barcode", locale: localName, name: "partBarcode");

  String get partSku => Intl.message("Part Sku", locale: localName, name: "partSku");

  String get partColor => Intl.message("Part Color", locale: localName, name: "partColor");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get deviceName => Intl.message("Device Name", locale: localName, name: "deviceName");

  String get partReceivedSuccessfully =>
      Intl.message("Part Received Successfully", locale: localName, name: "partReceivedSuccessfully");

  String get receiveAllCaps => Intl.message("RECEIVE", locale: localName, name: "receiveAllCaps");

  String get pickFrom => Intl.message("Pick From", locale: localName, name: "pickFrom");

  String get clickOnConfirmToReceive =>
      Intl.message("Click on Confirm to receive", locale: localName, name: "clickOnConfirmToReceive");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get confirm => Intl.message("Confirm", locale: localName, name: "confirm");

  String get orAllCAPs => Intl.message("OR", locale: localName, name: "orAllCAPs");

  String get enterThePartBarcode =>
      Intl.message("Enter the part barcode", locale: localName, name: "enterThePartBarcode");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get engineerReceiveDevice =>
      Intl.message("Engineer Receive Device", locale: localName, name: "engineerReceiveDevice");

  String get cashify => Intl.message("Cashify", locale: localName, name: "cashify");

  String get pendingDelivery => Intl.message("Pending Delivery", locale: localName, name: "pendingDelivery");

  String get pendingPickup => Intl.message("Pending Pickup", locale: localName, name: "pendingPickup");
}
