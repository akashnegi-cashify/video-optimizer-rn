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

  String get swipeUpToOpen => Intl.message("Swipe up to open", locale: localName, name: "swipeUpToOpen");

  String get acceptForWarranty => Intl.message("Accept For Warranty", locale: localName, name: "acceptForWarranty");

  String get addPart => Intl.message("Add Part", locale: localName, name: "addPart");

  String get searchPart => Intl.message("Search Part", locale: localName, name: "searchPart");

  String get sku => Intl.message("SKU", locale: localName, name: "sku");

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

  String get elssHome => Intl.message("Elss Home", locale: localName, name: "elssHome");

  String get name => Intl.message("Name", locale: localName, name: "name");

  String get employeeId => Intl.message("Employee Id", locale: localName, name: "employeeId");

  String get qualityCheck => Intl.message("Quality Check", locale: localName, name: "qualityCheck");

  String get searchParts => Intl.message("Search Parts", locale: localName, name: "searchParts");

  String get searchDeviceParts => Intl.message("Search device parts", locale: localName, name: "searchDeviceParts");

  String get grade => Intl.message("Grade", locale: localName, name: "grade");

  String get addParts => Intl.message("Add parts", locale: localName, name: "addParts");

  String get required => Intl.message("Required", locale: localName, name: "required");

  String get notRequired => Intl.message("Not Required", locale: localName, name: "notRequired");

  String get accept => Intl.message("Accept", locale: localName, name: "accept");

  String get discard => Intl.message("Discard", locale: localName, name: "discard");

  String get pna => Intl.message("PNA", locale: localName, name: "pna");

  String get discardParts => Intl.message("Discard Parts", locale: localName, name: "discardParts");

  String get areYouSureYouWantToRemoveTheseSelectedParts =>
      Intl.message("Are you sure you want to remove these selected parts?",
          locale: localName, name: "areYouSureYouWantToRemoveTheseSelectedParts");

  String get deviceDetails => Intl.message("Device Details", locale: localName, name: "deviceDetails");

  String get reject => Intl.message("Reject", locale: localName, name: "reject");

  String get retest => Intl.message("Retest", locale: localName, name: "retest");

  String get noPartsForPna => Intl.message("No Parts added for PNA", locale: localName, name: "noPartsForPna");

  String get selectPartsForPna => Intl.message("Select Parts for PNA", locale: localName, name: "selectPartsForPna");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get selectParts => Intl.message("Select Parts", locale: localName, name: "selectParts");

  String get noPartsAvailableForPna =>
      Intl.message("No Parts Available for PNA", locale: localName, name: "noPartsAvailableForPna");

  String get isRubbingApplicable =>
      Intl.message("Is Rubbing Applicable?", locale: localName, name: "isRubbingApplicable");

  String get deviceRubbing => Intl.message("Device Rubbing", locale: localName, name: "deviceRubbing");

  String get partsSubmittedSuccessfully =>
      Intl.message("Parts Submitted Successfully!!", locale: localName, name: "partsSubmittedSuccessfully");

  String get pnaStatusAppliedToSelectedParts =>
      Intl.message("PNA status applied to selected parts", locale: localName, name: "pnaStatusAppliedToSelectedParts");

  String get checkMarkPartForPna =>
      Intl.message("Check Mark part for PNA", locale: localName, name: "checkMarkPartForPna");

  String get deviceParts => Intl.message("Device Parts", locale: localName, name: "deviceParts");
}
