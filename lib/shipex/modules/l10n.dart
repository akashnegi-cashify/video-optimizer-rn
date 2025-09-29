import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get createShipment => Intl.message("Create Shipment", locale: localName, name: "createShipment");

  String get shipexDispatch => Intl.message("Shipex Dispatch", locale: localName, name: "shipexDispatch");

  String get shipexPackaging => Intl.message("Shipex Packaging", locale: localName, name: "shipexPackaging");

  String get noDeliveryPartnerFound =>
      Intl.message("No Delivery Partner Found", locale: localName, name: "noDeliveryPartnerFound");

  String get name => Intl.message("Name", locale: localName, name: "name");

  String get listOfDeliveryPartners =>
      Intl.message("List Of Delivery Partners", locale: localName, name: "listOfDeliveryPartners");

  String get scanOrEnterAwb => Intl.message("Scan Or Enter AWB", locale: localName, name: "scanOrEnterAwb");

  String get selectedDeliveryPartner =>
      Intl.message("Selected Delivery Partner", locale: localName, name: "selectedDeliveryPartner");

  String get lastAwb => Intl.message("Last AWB", locale: localName, name: "lastAwb");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get submitAwb => Intl.message("Submit AWB", locale: localName, name: "submitAwb");

  String get sendPdf => Intl.message("Send PDF", locale: localName, name: "sendPdf");

  String get sendCsv => Intl.message("Send CSV", locale: localName, name: "sendCsv");

  String get awb => Intl.message("AWB", locale: localName, name: "awb");

  String get takePictures => Intl.message("Take Pictures", locale: localName, name: "takePictures");

  String get proceed => Intl.message("Proceed", locale: localName, name: "proceed");

  String get finishDispatch => Intl.message("Finish Dispatch", locale: localName, name: "finishDispatch");

  String get pendingDispatch => Intl.message("Pending Dispatch", locale: localName, name: "pendingDispatch");

  String get requestSubmittedSuccessfully =>
      Intl.message("Request submitted successfully", locale: localName, name: "requestSubmittedSuccessfully");

  String get areYouSure => Intl.message("Are you sure you want to quit?", locale: localName, name: "areYouSure");

  String get allProgressWillBeLost =>
      Intl.message("All Progress will be lost.!!", locale: localName, name: "allProgressWillBeLost");

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get no => Intl.message("No", locale: localName, name: "no");

  String get retry => Intl.message("Retry", locale: localName, name: "retry");

  String get searchAwb => Intl.message("Search Awb", locale: localName, name: "searchAwb");

  String get noDataFound => Intl.message("No data found", locale: localName, name: "noDataFound");
}
