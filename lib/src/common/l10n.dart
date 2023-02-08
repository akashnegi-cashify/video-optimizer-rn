import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get pleaseWait => Intl.message("Please wait...", locale: localName, name: "pleaseWait");

  String get searchHere => Intl.message("Search here", locale: localName, name: "searchHere");

  String get yesterday => Intl.message("Yesterday", locale: localName, name: "yesterday");

  String get lastWeek => Intl.message("Last week", locale: localName, name: "lastWeek");

  String get thisMonth => Intl.message("This month", locale: localName, name: "thisMonth");

  String get lastMonth => Intl.message("Last month", locale: localName, name: "lastMonth");

  String get custom => Intl.message("Custom", locale: localName, name: "custom");
}
