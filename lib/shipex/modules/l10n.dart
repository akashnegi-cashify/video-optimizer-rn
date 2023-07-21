import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get shipexDispatch => Intl.message("Shipex Dispatch", locale: localName, name: "shipexDispatch");

  String get shipexPackaging => Intl.message("Shipex Packaging", locale: localName, name: "shipexPackaging");

  String get noDeliveryPartnerFound =>
      Intl.message("No Delivery Partner Found", locale: localName, name: "noDeliveryPartnerFound");

  String get name => Intl.message("Name", locale: localName, name: "name");

  String get listOfDeliveryPartners =>
      Intl.message("List Of Delivery Partners", locale: localName, name: "listOfDeliveryPartners");

  String get scanOrEnterAwb => Intl.message("Scan Or Enter AWB", locale: localName, name: "scanOrEnterAwb");

  String get selectDeliveryPartner =>
      Intl.message("Select Delivery Partner", locale: localName, name: "selectDeliveryPartner");

  String get lastAwb => Intl.message("Last AWB", locale: localName, name: "lastAwb");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get submitAwb => Intl.message("Submit AWB", locale: localName, name: "submitAwb");

  String get sendPdf => Intl.message("Send PDF", locale: localName, name: "sendPdf");

  String get sendCsv => Intl.message("Send CSV", locale: localName, name: "sendCsv");

  String get awb => Intl.message("AWB", locale: localName, name: "awb");

  String get takePictures => Intl.message("Take Pictures", locale: localName, name: "takePictures");

  String get proceed => Intl.message("Proceed", locale: localName, name: "proceed");

  String get finishDispatch => Intl.message("Finish Dispatch", locale: localName, name: "finishDispatch");
}
