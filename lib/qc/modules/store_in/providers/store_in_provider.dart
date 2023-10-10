import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreInProvider extends CshChangeNotifier {
  final String? barcode;

  static StoreInProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StoreInProvider>(context, listen: listen);
  }

  StoreInProvider(this.barcode);

}
