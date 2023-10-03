import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchItemProvider extends CshChangeNotifier {

  var awdNumberTextEditingController = TextEditingController();
  var barCodeTextEditingController = TextEditingController();

  static SearchItemProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SearchItemProvider>(context, listen: listen);
  }

  void resetControllerValue(){
    barCodeTextEditingController.clear();
    awdNumberTextEditingController.clear();
  }
}