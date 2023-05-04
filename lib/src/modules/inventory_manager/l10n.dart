import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get delivery => Intl.message("Delivery", locale: localName, name: "delivery");

  String get pendingDelivery => Intl.message("Pending Delivery", locale: localName, name: "pendingDelivery");

  String get assigned => Intl.message("Assigned", locale: localName, name: "assigned");

  String get selectGroupNameS => Intl.message("Select Group Name(s)", locale: localName, name: "selectGroupNameS");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get returns => Intl.message("Returns", locale: localName, name: "returns");

  String get summary => Intl.message("Summary", locale: localName, name: "summary");

  String get changePassword => Intl.message("Change password", locale: localName, name: "changePassword");

  String get logOut => Intl.message("LogOut", locale: localName, name: "logOut");

  String get appVersion => Intl.message("App Version", locale: localName, name: "appVersion");

  String get pleaseSelectAtleastOneGroupLocation => Intl.message("Please Select atleast one group location!!",
      locale: localName, name: "pleaseSelectAtleastOneGroupLocation");

  String get editLocations => Intl.message("Edit Locations", locale: localName, name: "editLocations");

  String get noDataFound => Intl.message("No Data found", locale: localName, name: "noDataFound");

  String get engineerSName => Intl.message("Engineer's Name", locale: localName, name: "engineerSName");

  String get searchItem => Intl.message("Search Item", locale: localName, name: "searchItem");

  String get showUrgentRequestsOnly =>
      Intl.message("Show Urgent Requests Only", locale: localName, name: "showUrgentRequestsOnly");

  String get idNotFound => Intl.message("Id Not found", locale: localName, name: "idNotFound");

  String get deviceBarcode => Intl.message("Device Barcode", locale: localName, name: "deviceBarcode");

  String get location => Intl.message("Location", locale: localName, name: "location");

  String get partStatus => Intl.message("Part Status", locale: localName, name: "partStatus");

  String get partColor => Intl.message("Part Color", locale: localName, name: "partColor");

  String get assignedAt => Intl.message("Assigned At", locale: localName, name: "assignedAt");

  String get repairType => Intl.message("Repair Type", locale: localName, name: "repairType");

  String get grade => Intl.message("Grade", locale: localName, name: "grade");

  String get pendingPartListScreen =>
      Intl.message("Pending Part List Screen", locale: localName, name: "pendingPartListScreen");

  String get noDidPresent => Intl.message("No DID present!!", locale: localName, name: "noDidPresent");

  String get partName => Intl.message("Part Name", locale: localName, name: "partName");

  String get status => Intl.message("Status", locale: localName, name: "status");

  String get sku => Intl.message("SKU", locale: localName, name: "sku");

  String get requestedAt => Intl.message("Requested At", locale: localName, name: "requestedAt");

  String get assignRider => Intl.message("Assign Rider", locale: localName, name: "assignRider");

  String get pendingPartDetails => Intl.message("Pending Part Details", locale: localName, name: "pendingPartDetails");

  String get pridIsNotPresent => Intl.message("Prid is not present", locale: localName, name: "pridIsNotPresent");

  String get deviceName => Intl.message("Device Name", locale: localName, name: "deviceName");

  String get sync => Intl.message("Sync", locale: localName, name: "sync");

  String get partSku => Intl.message("Part Sku", locale: localName, name: "partSku");

  String get requestedQuantity => Intl.message("Requested Quantity", locale: localName, name: "requestedQuantity");

  String get getQuantity => Intl.message("Get Quantity", locale: localName, name: "getQuantity");

  String get availableQuantity => Intl.message("Available Quantity", locale: localName, name: "availableQuantity");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get assign => Intl.message("Assign", locale: localName, name: "assign");

  String get deadPart => Intl.message("Dead Part", locale: localName, name: "deadPart");

  String get alternatePart => Intl.message("Alternate Part", locale: localName, name: "alternatePart");

  String get goBack => Intl.message("Go Back", locale: localName, name: "goBack");

  String get suggestedBarcode => Intl.message("Suggested Barcode", locale: localName, name: "suggestedBarcode");

  String get assignBarcodeScreen =>
      Intl.message("Assign Barcode Screen", locale: localName, name: "assignBarcodeScreen");

  String get next => Intl.message("Next", locale: localName, name: "next");

  String get enterBarcode => Intl.message("Enter Barcode", locale: localName, name: "enterBarcode");

  String get areYouSureYouWantToCancel =>
      Intl.message(" Are you sure, you want to cancel?", locale: localName, name: "areYouSureYouWantToCancel");

  String get ok => Intl.message("ok", locale: localName, name: "ok");

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get no => Intl.message("No", locale: localName, name: "no");

  String get partCanceledSuccessfully =>
      Intl.message("Part Canceled successfully", locale: localName, name: "partCanceledSuccessfully");

  String get listOfRiders => Intl.message("List Of Riders", locale: localName, name: "listOfRiders");

  String get noRiderPresent => Intl.message("No Rider Present", locale: localName, name: "noRiderPresent");

  String get pleaseAssignRider => Intl.message("Please Assign Rider", locale: localName, name: "pleaseAssignRider");

  String get searchRiderByName => Intl.message("Search rider by name", locale: localName, name: "searchRiderByName");

  String get riderAssignedSuccessfully =>
      Intl.message("Rider Assigned Successfully", locale: localName, name: "riderAssignedSuccessfully");

  String get assignedDeviceDetails =>
      Intl.message("Assigned Device Details", locale: localName, name: "assignedDeviceDetails");

  String get assignPartsDetailsScreen =>
      Intl.message("Assign Parts Details Screen", locale: localName, name: "assignPartsDetailsScreen");

  String get partBarcode => Intl.message("Part Barcode", locale: localName, name: "partBarcode");

  String get areYouSureYouWantToUnlinkThePart => Intl.message("Are you sure you want to unlink the part?",
      locale: localName, name: "areYouSureYouWantToUnlinkThePart");

  String get partUnlinkedSuccessfully =>
      Intl.message("Part Unlinked Successfully", locale: localName, name: "partUnlinkedSuccessfully");

  String get receive => Intl.message("Receive", locale: localName, name: "receive");

  String get searchBarcode => Intl.message("Search Barcode", locale: localName, name: "searchBarcode");

  String get itemStatus => Intl.message("Item Status", locale: localName, name: "itemStatus");

  String get faultySpare => Intl.message("Faulty Spare", locale: localName, name: "faultySpare");

  String get sendPartBackToInventory =>
      Intl.message("SEND PART BACK TO INVENTORY", locale: localName, name: "sendPartBackToInventory");

  String get statusChangedSuccessfully =>
      Intl.message("Status Changed Successfully", locale: localName, name: "statusChangedSuccessfully");

  String get scanPartBarcode => Intl.message("Scan Part Barcode", locale: localName, name: "scanPartBarcode");

  String get dataFetchedSuccessfully =>
      Intl.message("Data Fetched Successfully", locale: localName, name: "dataFetchedSuccessfully");

  String get summaryScreen => Intl.message("Summary Screen", locale: localName, name: "summaryScreen");

  String get assignedForDelivery =>
      Intl.message("Assigned for Delivery", locale: localName, name: "assignedForDelivery");

  String get pendingReturn => Intl.message("Pending Return", locale: localName, name: "pendingReturn");

  String get aodDesc => Intl.message("Number of parts that are assigned and their rider assignment in pending",
      locale: localName, name: "aodDesc");

  String get pdDesc =>
      Intl.message("Number of part requests that are not yet assigned", locale: localName, name: "pdDesc");

  String get prDesc =>
      Intl.message("Number of returned parts that are received by you whose return to inventory is pending",
          locale: localName, name: "prDesc");

  String get areYouSureYouWantToLinkDeadPart => Intl.message("Are you sure you want to link dead part?",
      locale: localName, name: "areYouSureYouWantToLinkDeadPart");

  String get deadPartLinkedSuccessfully =>
      Intl.message("Dead part linked successfully", locale: localName, name: "deadPartLinkedSuccessfully");

  String get alternatePartList => Intl.message("Alternate Part List", locale: localName, name: "alternatePartList");

  String get originalPartRequest =>
      Intl.message("Original Part Request", locale: localName, name: "originalPartRequest");

  String get alternatePartsAvailable =>
      Intl.message("Alternate Parts Available", locale: localName, name: "alternatePartsAvailable");

  String get request => Intl.message("Request", locale: localName, name: "request");

  String get alternatePartDataFetched =>
      Intl.message("Alternate part data fetched!!", locale: localName, name: "alternatePartDataFetched");

  String get alternatePartSku => Intl.message("Alternate Part SKU", locale: localName, name: "alternatePartSku");

  String get alternatePartStatus =>
      Intl.message("Alternate Part Status", locale: localName, name: "alternatePartStatus");
}
