// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get viewReport => Intl.message("View Report", locale: localName, name: "viewReport");

  String get action => Intl.message("Action", locale: localName, name: "action");

  String get receiveDevices => Intl.message("Receive Devices", locale: localName, name: "receiveDevices");

  String get searchBarcode => Intl.message("Search Barcode", locale: localName, name: "searchBarcode");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get partBarcode => Intl.message("Part Barcode", locale: localName, name: "partBarcode");

  String get enterRemarksIfAny => Intl.message("Enter Remarks (if Any)", locale: localName, name: "enterRemarksIfAny");

  String get faulty => Intl.message("Faulty", locale: localName, name: "faulty");

  String get working => Intl.message("Working", locale: localName, name: "working");

  String areYouSureYouWantToMarkPartAsFaulty(String partBarcode) =>
      Intl.message("Are you sure you want to mark $partBarcode as faulty?",
          locale: localName, name: "areYouSureYouWantToMarkPartAsFaulty", args: [partBarcode]);

  String areYouSureYouWantToMarkPartAsOk(String partBarcode) =>
      Intl.message("Are you sure you want to mark $partBarcode as ok?",
          locale: localName, name: "areYouSureYouWantToMarkPartAsOk", args: [partBarcode]);

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get no => Intl.message("No", locale: localName, name: "no");

  String get statusUpdatedSuccessfully =>
      Intl.message("Status Updated Successfully", locale: localName, name: "statusUpdatedSuccessfully");

  String get noProductIdFound => Intl.message("No Product Id Found", locale: localName, name: "noProductIdFound");

  String get part => Intl.message("Part", locale: localName, name: "part");

  String get quantity => Intl.message("Quantity", locale: localName, name: "quantity");

  String get dateRange => Intl.message("Date Range", locale: localName, name: "dateRange");

  String get filter => Intl.message("Filter", locale: localName, name: "filter");

  String get remarks => Intl.message("Remarks", locale: localName, name: "remarks");

  String get reason => Intl.message("Reason", locale: localName, name: "reason");
}
