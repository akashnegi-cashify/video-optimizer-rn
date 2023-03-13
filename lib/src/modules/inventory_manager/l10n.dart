import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get delivery => Intl.message("Delivery", locale: localName, name: "delivery");

  String get pendingDelivery => Intl.message("Pending Delivery", locale: localName, name: "pendingDelivery");

  String get assigned => Intl.message("Assigned", locale: localName, name: "assigned");
}
