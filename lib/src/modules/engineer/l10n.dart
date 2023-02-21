import 'package:flutter_trc/src/common/l10n.dart' as l10n_common;
import 'package:intl/intl.dart';

class L10n extends l10n_common.L10n {
  L10n(super.context);

  String get home => Intl.message("Home", locale: localName, name: "home");

  String get receiveDevices => Intl.message("Receive Devices", locale: localName, name: "receiveDevices");

  String get myDevices => Intl.message("My Devices", locale: localName, name: "myDevices");

  String get manageParts => Intl.message("Manage Parts", locale: localName, name: "manageParts");

  String get viewReport => Intl.message("View Report", locale: localName, name: "viewReport");

  String get deviceInfo => Intl.message("Device Info", locale: localName, name: "deviceInfo");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get productTitle => Intl.message("Product Title", locale: localName, name: "productTitle");

  String get status => Intl.message("Status", locale: localName, name: "status");

  String get somethingWentWrong => Intl.message("Something went wrong!", locale: localName, name: "somethingWentWrong");

  String get allDevices => Intl.message("All Devices", locale: localName, name: "allDevices");

  String get wipDevices => Intl.message("WIP Devices", locale: localName, name: "wipDevices");

  String get action => Intl.message("Action", locale: localName, name: "action");

  String get barcode => Intl.message("Barcode", locale: localName, name: "barcode");

  String get sendToInProgress => Intl.message("Send To In Progress", locale: localName, name: "sendToInProgress");

  String get deviceSentToInProgress =>
      Intl.message("Device sent to progress, successfully!", locale: localName, name: "deviceSentToInProgress");

  String get wipOption => Intl.message("Wip Option", locale: localName, name: "wipOption");

  String get putOnHold => Intl.message("Put On Hold", locale: localName, name: "putOnHold");

  String get startWork => Intl.message("Start Work", locale: localName, name: "startWork");

  String get markOk => Intl.message("Mark Ok", locale: localName, name: "markOk");

  String get markFI => Intl.message("Mark FI", locale: localName, name: "markFI");

  String get markFFI => Intl.message("Mark FFI", locale: localName, name: "markFFI");

  String get markNR => Intl.message("Mark NR", locale: localName, name: "markNR");

  String get repairDone => Intl.message("Repair Done", locale: localName, name: "repairDone");

  String get viewParts => Intl.message("View Parts", locale: localName, name: "viewParts");

  String get sendToTL => Intl.message("Send to TL", locale: localName, name: "sendToTL");

  String get repairType => Intl.message("Repair Type", locale: localName, name: "repairType");

  String get grade => Intl.message("Grade", locale: localName, name: "grade");

  String get deviceIMEI => Intl.message("Device IMEI", locale: localName, name: "deviceIMEI");

  String get selfAssignPart => Intl.message("Self assign part", locale: localName, name: "selfAssignPart");

  String get orderPart => Intl.message("Order part", locale: localName, name: "orderPart");

  String get partName => Intl.message("Part Name", locale: localName, name: "partName");

  String get partBarcode => Intl.message("Part Barcode", locale: localName, name: "partBarcode");

  String get partSku => Intl.message("Part Sku", locale: localName, name: "partSku");

  String get partStatus => Intl.message("Part Status", locale: localName, name: "partStatus");

  String get rmsRemarks => Intl.message("RMS Remarks:", locale: localName, name: "rmsRemarks");

  String get remarks => Intl.message("Remarks", locale: localName, name: "remarks");

  String get deviceIssues => Intl.message("Device Issues:", locale: localName, name: "deviceIssues");

  String get reQcFailReason => Intl.message("Re-QC Fail Reason", locale: localName, name: "reQcFailReason");

  String get clickOnConfirmToSendTL =>
      Intl.message("Click on confirm to send to TL", locale: localName, name: "clickOnConfirmToSendTL");

  String get deviceName => Intl.message("Device Name", locale: localName, name: "deviceName");

  String get color => Intl.message("Color", locale: localName, name: "color");

  String get deviceStatusUpdatedSuccessfully =>
      Intl.message("Device Status Updated Successfully!", locale: localName, name: "deviceStatusUpdatedSuccessfully");

  String get deviceSentToTLSuccessfully =>
      Intl.message("Device marked to sent to TL Successfully", locale: localName, name: "deviceSentToTLSuccessfully");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get confirm => Intl.message("Confirm", locale: localName, name: "confirm");

  String get consume => Intl.message("Consume", locale: localName, name: "consume");

  String get selectAReasonToContinue =>
      Intl.message("* Select a Return Reason to proceed", locale: localName, name: "selectAReasonToContinue");

  String get imageUploadedSuccessfully =>
      Intl.message("Image Uploaded Successfully", locale: localName, name: "imageUploadedSuccessfully");

  String get receive => Intl.message("Receive", locale: localName, name: "receive");

  String get return_ => Intl.message("Return", locale: localName, name: "return_");

  String get areYouSureYouWantToReceive =>
      Intl.message("Are you sure you want to receive", locale: localName, name: "areYouSureYouWantToReceive");

  String get deviceReceivedSuccessfully =>
      Intl.message("Device Received successfully!", locale: localName, name: "deviceReceivedSuccessfully");

  String get clickOnConfirmToCancel =>
      Intl.message("Click on Confirm to Cancel", locale: localName, name: "clickOnConfirmToCancel");

  String get chooseYourResponse => Intl.message("Choose your response", locale: localName, name: "chooseYourResponse");

  String cancelPartRequestSuccess(String? partName) =>
      Intl.message("Part request for part name $partName is successfully cancelled!",
          locale: localName, name: "cancelPartRequestSuccess");

  String consumePartSuccess(String? partName) =>
      Intl.message("Part name $partName is successfully consumed!", locale: localName, name: "consumePartSuccess");

  String get partSentToReturn =>
      Intl.message("Part return request Successfull!", locale: localName, name: "partSentToReturn");

  String get enterPartBarcode => Intl.message("Enter part barcode", locale: localName, name: "enterPartBarcode");

  String get enterDeviceBarcode => Intl.message("Enter device barcode", locale: localName, name: "enterDeviceBarcode");

  String get or => Intl.message("Or", locale: localName, name: "or");

  String get scan => Intl.message("Scan", locale: localName, name: "scan");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get request => Intl.message("Request", locale: localName, name: "request");

  String get received => Intl.message("Received", locale: localName, name: "received");

  String get consumed => Intl.message("Consumed", locale: localName, name: "consumed");

  String get pending => Intl.message("Pending", locale: localName, name: "pending");

  String get assigned => Intl.message("Assigned", locale: localName, name: "assigned");

  String get device => Intl.message("Device", locale: localName, name: "device");

  String get parts => Intl.message("Parts", locale: localName, name: "parts");

  String get pleaseEnterDeviceBarcodeToProceed => Intl.message("Please enter device barcode to proceed",
      locale: localName, name: "pleaseEnterDeviceBarcodeToProceed");

  String get pleaseEnterPartBarcodeToProceed =>
      Intl.message("Please enter part barcode to proceed", locale: localName, name: "pleaseEnterPartBarcodeToProceed");

  String get partAssignedSuccessfully =>
      Intl.message("Part assigned successfully!", locale: localName, name: "partAssignedSuccessfully");

  String get partsOrderedSuccessfully =>
      Intl.message("Parts ordered successfully!", locale: localName, name: "partsOrderedSuccessfully");

  String get leadingEngineers => Intl.message("Leading Engineers", locale: localName, name: "leadingEngineers");

  String get efficiency => Intl.message("Efficiency", locale: localName, name: "efficiency");

  String get avgRepairTime => Intl.message("Avg repair time", locale: localName, name: "avgRepairTime");

  String get volume => Intl.message("Volume", locale: localName, name: "volume");

  String get totalAssignedDevices =>
      Intl.message("Total Assigned Devices", locale: localName, name: "totalAssignedDevices");

  String get markedOk => Intl.message("Marked Ok", locale: localName, name: "markedOk");

  String get markedOkPass => Intl.message("Marked Ok Pass", locale: localName, name: "markedOkPass");

  String get markedOkFail => Intl.message("Marked Ok Fail", locale: localName, name: "markedOkFail");

  String get avgPartCost => Intl.message("Avg Part Cost", locale: localName, name: "avgPartCost");

  String get avgPartConsumption => Intl.message("Avg Part Consumption", locale: localName, name: "avgPartConsumption");

  String get partsAssigned => Intl.message("Parts Assigned", locale: localName, name: "partsAssigned");

  String get partsConsumed => Intl.message("Parts Consumed", locale: localName, name: "partsConsumed");

  String get partsReturned => Intl.message("Parts Returned", locale: localName, name: "partsReturned");

  String get partsRequested => Intl.message("Parts Requested", locale: localName, name: "partsRequested");
}
