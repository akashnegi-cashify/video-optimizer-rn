import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get audit => Intl.message("Audit", locale: localName, name: "audit");

  String get auditQuestions => Intl.message("Audit Questions", locale: localName, name: "auditQuestions");

  String get next => Intl.message("Next", locale: localName, name: "next");

  String get back => Intl.message("Back", locale: localName, name: "back");

  String get submit => Intl.message("Submit", locale: localName, name: "submit");

  String get noQuestionsFound => Intl.message("No Questions found!!", locale: localName, name: "noQuestionsFound");

  String get auditSummary => Intl.message("Audit Summary", locale: localName, name: "auditSummary");

  String get noSummaryFound => Intl.message("No Summary Found", locale: localName, name: "noSummaryFound");

  String get done => Intl.message("Done", locale: localName, name: "done");

  String get q => Intl.message("Q", locale: localName, name: "q");

  String get ans => Intl.message("Ans", locale: localName, name: "ans");

  String get auditBarcodeScanner =>
      Intl.message("Audit Barcode Scanner", locale: localName, name: "auditBarcodeScanner");

  String get auditBarcode => Intl.message("Audit Barcode", locale: localName, name: "auditBarcode");

  String get pleaseEnterBarcode =>
      Intl.message("Please enter barcode!!", locale: localName, name: "pleaseEnterBarcode");

  String get scanBarcode => Intl.message("Scan Barcode", locale: localName, name: "scanBarcode");

  String get scanAnotherBarcode => Intl.message("Scan Another Barcode", locale: localName, name: "scanAnotherBarcode");

  String get dataSubmittedSuccessfully =>
      Intl.message("Data Submitted Successfully", locale: localName, name: "dataSubmittedSuccessfully");

  String get somethingWentWrong =>
      Intl.message("Something went wrong!!", locale: localName, name: "somethingWentWrong");

  String get imageUploadedSuccessfully =>
      Intl.message("Image Uploaded Successfully", locale: localName, name: "imageUploadedSuccessfully");
  String get pleaseUploadRequiredImage => Intl.message("Please Upload required image", locale: localName, name: "pleaseUploadRequiredImage");
}
