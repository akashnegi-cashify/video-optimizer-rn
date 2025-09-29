import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get elss => Intl.message("ELSS", locale: localName, name: "elss");

  String get scanBarcode => Intl.message("Scan Barcode", locale: localName, name: "scanBarcode");

  String get loggedInUser => Intl.message("Logged In User", locale: localName, name: "loggedInUser");

  String get appVersion => Intl.message("App Version", locale: localName, name: "appVersion");

  String get partSelection => Intl.message("Part Selection", locale: localName, name: "partSelection");

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get deviceName => Intl.message("Device Name", locale: localName, name: "deviceName");

  String get repairType => Intl.message("Repair Type", locale: localName, name: "repairType");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get deviceColour => Intl.message("Device Colour", locale: localName, name: "deviceColour");

  String get rmsRemark => Intl.message("RMS Remark", locale: localName, name: "rmsRemark");

  String get deviceImei => Intl.message("Device IMEI", locale: localName, name: "deviceImei");

  String get serialNumber => Intl.message("Serial No.", locale: localName, name: "serialNumber");

  String get swipeUpToOpen => Intl.message("Swipe up to open", locale: localName, name: "swipeUpToOpen");

  String get acceptForWarranty => Intl.message("Accept For Warranty", locale: localName, name: "acceptForWarranty");

  String get addPart => Intl.message("Add Part", locale: localName, name: "addPart");

  String get searchPart => Intl.message("Search Part", locale: localName, name: "searchPart");

  String get sku => Intl.message("SKU", locale: localName, name: "sku");

  String get skuName => Intl.message("SKU Name", locale: localName, name: "skuName");

  String get colour => Intl.message("Colour", locale: localName, name: "colour");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get noPartsFound => Intl.message("No Parts Found", locale: localName, name: "noPartsFound");

  String get noResultsFound => Intl.message("No Results Found!!", locale: localName, name: "noResultsFound");

  String get captureImages => Intl.message("Capture Images", locale: localName, name: "captureImages");

  String get done => Intl.message("Done", locale: localName, name: "done");

  String get noPartFound => Intl.message("No Part Found", locale: localName, name: "noPartFound");

  String get rubbingApplicable => Intl.message("Rubbing Applicable", locale: localName, name: "rubbingApplicable");

  String get pnaApplicable => Intl.message("PNA Applicable", locale: localName, name: "pnaApplicable");

  String get glassChangeApplicable =>
      Intl.message("Glass Change Applicable", locale: localName, name: "glassChangeApplicable");

  String get swipeDownToClose => Intl.message("Swipe down to close", locale: localName, name: "swipeDownToClose");

  String get imageUploadedSuccessfully =>
      Intl.message("Image Uploaded Successfully", locale: localName, name: "imageUploadedSuccessfully");

  String get dataSubmittedSuccessfully =>
      Intl.message("Data Submitted Successfully!!", locale: localName, name: "dataSubmittedSuccessfully");

  String get errorInSubmittingDetails =>
      Intl.message("Error in submitting details!!", locale: localName, name: "errorInSubmittingDetails");

  String get logout => Intl.message("Logout", locale: localName, name: "logout");

  String get doYouWantToLogout => Intl.message("Do you want to logout?", locale: localName, name: "doYouWantToLogout");

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get techRefurbishmentCenter =>
      Intl.message("Tech Refurbishment Center", locale: localName, name: "techRefurbishmentCenter");

  String get qc => Intl.message("QC", locale: localName, name: "qc");

  String get trc => Intl.message("TRC", locale: localName, name: "trc");

  String get noPartAddedForPna => Intl.message("No Part Added For PNA", locale: localName, name: "noPartAddedForPna");

  String get pleaseSelectPartsForPna =>
      Intl.message("Please Select parts for PNA", locale: localName, name: "pleaseSelectPartsForPna");

  String get selectParts => Intl.message("Select Parts", locale: localName, name: "selectParts");

  String get addedParts => Intl.message("Added Parts", locale: localName, name: "addedParts");

  String get selectedPartsForPna =>
      Intl.message("Selected Parts for PNA", locale: localName, name: "selectedPartsForPna");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get submitParts => Intl.message("Submit Parts", locale: localName, name: "submitParts");

  String get areYouSureYouWantToSubmit =>
      Intl.message("Are you sure you want to submit?", locale: localName, name: "areYouSureYouWantToSubmit");

  String get techRefurbishCenter =>
      Intl.message("Tech Refurbish Center", locale: localName, name: "techRefurbishCenter");

  String get deviceDetails => Intl.message("Device Details", locale: localName, name: "deviceDetails");

  String get selectBrand => Intl.message("Select Brand", locale: localName, name: "selectBrand");

  String get selectProduct => Intl.message("Select Product", locale: localName, name: "selectProduct");

  String get selectColor => Intl.message("Select Color", locale: localName, name: "selectColor");

  String get pleaseSelectBrand => Intl.message("Please Select Brand!!", locale: localName, name: "pleaseSelectBrand");

  String get pleaseSelectProduct =>
      Intl.message("Please Select Product!!", locale: localName, name: "pleaseSelectProduct");

  String get quantity => Intl.message("Quantity", locale: localName, name: "quantity");
}
