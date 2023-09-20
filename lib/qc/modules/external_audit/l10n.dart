import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get enterAwbImeiBarcodeNumber =>
      Intl.message("Enter Awb IMEI number or Barcode", locale: localName, name: "enterAwbImeiBarcodeNumber");

  String get step1 => Intl.message("Step 1", locale: localName, name: "step1");

  String get step4 => Intl.message("Step 4", locale: localName, name: "step4");

  String get receiveStock => Intl.message("Receive Stock", locale: localName, name: "receiveStock");

  String get receiveReturn => Intl.message("Receive Return", locale: localName, name: "receiveReturn");

  String get dispatch => Intl.message("Dispatch", locale: localName, name: "dispatch");

  String get scanUniqueIdentifier =>
      Intl.message("Scan Unique Identifier", locale: localName, name: "scanUniqueIdentifier");

  String get addImagesAndVideos => Intl.message("Add Images and Videos", locale: localName, name: "addImagesAndVideos");
}
