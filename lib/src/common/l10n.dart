import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(context, {bool listen = true}) : super(context, listen: listen);

  String get pleaseWait => Intl.message("Please wait...", locale: localName, name: "pleaseWait");

  String get searchHere => Intl.message("Search here", locale: localName, name: "searchHere");

  String get yesterday => Intl.message("Yesterday", locale: localName, name: "yesterday");

  String get lastWeek => Intl.message("Last week", locale: localName, name: "lastWeek");

  String get thisMonth => Intl.message("This month", locale: localName, name: "thisMonth");

  String get lastMonth => Intl.message("Last month", locale: localName, name: "lastMonth");

  String get custom => Intl.message("Custom", locale: localName, name: "custom");

  String get doYouWantToLogout => Intl.message("Do you want to logout?", locale: localName, name: "doYouWantToLogout");

  String get logout => Intl.message("Logout", locale: localName, name: "logout");

  String get yes => Intl.message("Yes", locale: localName, name: "yes");

  String get cancel => Intl.message("Cancel", locale: localName, name: "cancel");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get update => Intl.message("Update", locale: localName, name: "update");

  String get enterBarcode => Intl.message("Enter Barcode", locale: localName, name: "Enter Barcode");

  String get newVersionAvailable =>
      Intl.message("New Version Available", locale: localName, name: "newVersionAvailable");

  String get majorVersionDescription =>
      Intl.message("Please update app to new version to continue", locale: localName, name: "majorVersionDescription");
}
