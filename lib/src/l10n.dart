import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get noDataFound => Intl.message("No Data Found", locale: localName, name: "noDataFound");

  String get appName => Intl.message('Tech Refurbished Centre', locale: localName, name: 'appName');
}
