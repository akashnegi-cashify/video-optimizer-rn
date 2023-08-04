import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get shipexPacking => Intl.message("Shipex Packing", locale: localName, name: "shipexPacking");

  String get newString => Intl.message("New", locale: localName, name: "newString");

  String get pending => Intl.message("Pending", locale: localName, name: "pending");

  String get noPendingListDataFound =>
      Intl.message("No Pending List Data Found!!", locale: localName, name: "noPendingListDataFound");

  String get noNewDataFound => Intl.message("No New Data Found", locale: localName, name: "noNewDataFound");

  String get name => Intl.message("Name", locale: localName, name: "name");

  String get qty => Intl.message("Qty", locale: localName, name: "qty");

  String get status => Intl.message("Status", locale: localName, name: "status");

  String get packagingProcedure => Intl.message("Packaging Procedure", locale: localName, name: "packagingProcedure");

  String get lotName => Intl.message("Lot Name", locale: localName, name: "lotName");

  String get scanOrEnterAwbToProceed =>
      Intl.message("Scan AWB to proceed", locale: localName, name: "scanOrEnterAwbToProceed");

  String get scanOrEnterInvoiceNumber =>
      Intl.message("Scan or Enter Invoice Number", locale: localName, name: "scanOrEnterInvoiceNumber");

  String get step1Of3 => Intl.message("Step 1 of 3", locale: localName, name: "step1Of3");

  String get step2Of3 => Intl.message("Step 2 of 3", locale: localName, name: "step2Of3");

  String get step3Of3 => Intl.message("Step 3 of 3", locale: localName, name: "step3Of3");

  String get enterAwbNo => Intl.message("Enter AWB No.", locale: localName, name: "enterAwbNo");

  String get enterInvoiceNo => Intl.message("Enter Invoice No.", locale: localName, name: "enterInvoiceNo");

  String get enterDeviceBarcode => Intl.message("Enter Device Barcode", locale: localName, name: "enterDeviceBarcode");

  String get scanOrEnterAnyDeviceBarcode =>
      Intl.message("Scan any device of the lot", locale: localName, name: "scanOrEnterAnyDeviceBarcode");

  String get scanBarcodeToStartRecording =>
      Intl.message("Scan Barcode to start Recording", locale: localName, name: "scanBarcodeToStartRecording");

  String get selectTheCaptureProcess =>
      Intl.message("Select the capture process", locale: localName, name: "selectTheCaptureProcess");

  String get monitoringApp => Intl.message("Monitoring App", locale: localName, name: "monitoringApp");

  String get cctv => Intl.message("CCTV", locale: localName, name: "cctv");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  get completePackaging => Intl.message("Complete Packaging", locale: localName, name: "completePackaging");
}
