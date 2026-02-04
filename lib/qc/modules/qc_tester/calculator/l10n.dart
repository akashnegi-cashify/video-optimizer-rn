// coverage:ignore-file
import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get pleaseSelectTheIssuesInTheDevice => Intl.message("Please select the issues in the device",
      locale: localName, name: "pleaseSelectTheIssuesInTheDevice");

  String get scanCdpQrCode => Intl.message("Scan CDP Qr Code", locale: localName, name: "scanCdpQrCode");

  String get scanDeviceBarcode => Intl.message("Scan Device Barcode", locale: localName, name: "scanDeviceBarcode");

  String get startScanningCdpQrCode => Intl.message("Start scanning CDP Qr Code", locale: localName, name: "startScanningCdpQrCode");
}
