// coverage:ignore-file
import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get docLinks => Intl.message("Doc Link", locale: localName, name: "docLinks");

  String get download => Intl.message("Download", locale: localName, name: "download");

  String get searchByName => Intl.message("Search By Name", locale: localName, name: "searchByName");

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get createShipment => Intl.message("Create Shipment", locale: localName, name: "createShipment");

  String get pending => Intl.message("Pending", locale: localName, name: "pending");

  String get created => Intl.message("Created", locale: localName, name: "created");

  String get lot => Intl.message("Lot", locale: localName, name: "lot");

  String get lotName => Intl.message("Lot Name", locale: localName, name: "lotName");

  String get devices => Intl.message("Devices", locale: localName, name: "devices");

  String get cameraQr => Intl.message("Camera QR", locale: localName, name: "cameraQr");

  String get invoice => Intl.message("Invoice", locale: localName, name: "invoice");

  String get uploadEWayBill => Intl.message("Upload E-Way Bill", locale: localName, name: "uploadEWayBill");

  String get awbNumber => Intl.message("AWB Number", locale: localName, name: "awbNumber");

  String get date => Intl.message("Date", locale: localName, name: "date");

  String get time => Intl.message("Time", locale: localName, name: "time");

  String get uploadDocument => Intl.message("Upload Document", locale: localName, name: "uploadDocument");

  String get documentSelected => Intl.message("Document Selected", locale: localName, name: "documentSelected");

  String get takeImage => Intl.message("Take Image", locale: localName, name: "takeImage");

  String get chooseFile => Intl.message("Choose File", locale: localName, name: "chooseFile");

  String get save => Intl.message("Save", locale: localName, name: "save");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get selectBox => Intl.message("Select Box", locale: localName, name: "selectBox");

  String get update => Intl.message("Update", locale: localName, name: "update");

  String get createManualShipment =>
      Intl.message("Create Manual Shipment", locale: localName, name: "createManualShipment");

  String get generate => Intl.message("Generate", locale: localName, name: "generate");

  String get exit => Intl.message("Exit", locale: localName, name: "exit");
}
