import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackagingProvider extends CshChangeNotifier {
  String? _enteredAwbNumber;
  String? _enterInvoiceNumber;

  static PackagingProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PackagingProvider>(context, listen: listen);
  }

  set awbNumber(String awb) {
    _enteredAwbNumber = awb;
  }

  String get awbNumber => _enteredAwbNumber ?? "";

  set invoiceNumber(String invoice) {
    _enterInvoiceNumber = invoice;
  }

  String get invoiceNumber => _enterInvoiceNumber ?? "";
}
