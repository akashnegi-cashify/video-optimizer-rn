import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get change => Intl.message("Change", locale: localName, name: "change");

  String get currentFacility => Intl.message("Current Facility", locale: localName, name: "currentFacility");
}
