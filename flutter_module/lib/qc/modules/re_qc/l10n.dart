// coverage:ignore-file
import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get refresh => Intl.message("Refresh", locale: localName, name: "refresh");

  String get lotQty => Intl.message("Lot Qty", locale: localName, name: "lotQty");

  String get doneQty => Intl.message("Done Qty", locale: localName, name: "doneQty");

  String get pendingQty => Intl.message("Pending Qty", locale: localName, name: "pendingQty");

  String get auditQty => Intl.message("Audit Qty", locale: localName, name: "auditQty");

  String get lotType => Intl.message("Lot Type", locale: localName, name: "lotType");

  String get skip => Intl.message("Skip", locale: localName, name: "skip");

  String get searchByLotName => Intl.message("Search by lot name", locale: localName, name: "searchByLotName");

  String get searchByBarcode => Intl.message("Search by barcode", locale: localName, name: "searchByBarcode");

}
