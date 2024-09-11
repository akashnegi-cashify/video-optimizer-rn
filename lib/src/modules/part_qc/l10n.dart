import 'package:intl/intl.dart';
import 'package:localization/localization/base_l10n.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get partQc => Intl.message("Part QC", locale: localName, name: "partQc");

  String get reader => Intl.message("Reader", locale: localName, name: "reader");

  String get retrievedParts => Intl.message("Retrieved Parts", locale: localName, name: "retrievedParts");

  String get qcPending => Intl.message("Qc Pending", locale: localName, name: "qcPending");

  String get scanPartBarcode => Intl.message("Scan Part Barcode", locale: localName, name: "scanPartBarcode");

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get partBarcode => Intl.message("Part Barcode", locale: localName, name: "partBarcode");

  String get partSku => Intl.message("Part Sku", locale: localName, name: "partSku");

  String get skuName => Intl.message("Sku Name", locale: localName, name: "skuName");

  String get partName => Intl.message("Part Name", locale: localName, name: "partName");

  String get partColor => Intl.message("Part Color", locale: localName, name: "partColor");

  String get partStatus => Intl.message("Part Status", locale: localName, name: "partStatus");

  String get faultySpare => Intl.message("faulty Spare", locale: localName, name: "faultySpare");

  String get spareOk => Intl.message("Spare Ok", locale: localName, name: "spareOk");

  String get noPridFound => Intl.message("No prid found", locale: localName, name: "noPridFound");

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get no => Intl.message("No", locale: localName, name: "no");

  String areYouSureYouWantToMarkPartAsFaulty(String partBarcode) => Intl.message("Are you sure you want to mark $partBarcode as faulty?",
      locale: localName, name: "areYouSureYouWantToMarkPartAsFaulty", args: [partBarcode]);

  String areYouSureYouWantToMarkPartAsOk(String partBarcode) => Intl.message("Are you sure you want to mark $partBarcode as ok?",
      locale: localName, name: "areYouSureYouWantToMarkPartAsOk", args: [partBarcode]);

  String get statusUpdatedSuccessfully =>
      Intl.message("Status Updated Successfully", locale: localName, name: "statusUpdatedSuccessfully");
}
