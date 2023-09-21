import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidateAwdProvider extends CshChangeNotifier {

  var awdNumberTextEditingController = TextEditingController(text:'qw323');
  var barCodeTextEditingController = TextEditingController(text:'qw1001');

  static ValidateAwdProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ValidateAwdProvider>(context, listen: listen);
  }
}