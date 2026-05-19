// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get partName => Intl.message("Part Name", locale: localName, name: "partName");

  String get selectReason => Intl.message("Select Reason", locale: localName, name: "selectReason");

  String get attachPartImage => Intl.message("Attach Part Image", locale: localName, name: "attachPartImage");

  String get barcode => Intl.message("Barcode", locale: localName, name: "barcode");

  String get remark => Intl.message("Remark", locale: localName, name: "remark");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get completeRequiredFieldToSubmit =>
      Intl.message("Complete Required field to submit", locale: localName, name: "completeRequiredFieldToSubmit");
}
