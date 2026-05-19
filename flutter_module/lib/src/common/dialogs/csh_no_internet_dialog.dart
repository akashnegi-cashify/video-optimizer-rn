import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';

showNoInternetDialog(BuildContext context, {required VoidCallback onRetry}) {
  showPopup(
    context,
    title: "Slow or No Internet Connection",
    desc: "Please check your internet connection and try again.",
    barrierDismissible: false,
    actions: [
      CshMediumButton(
        text: "Retry",
        onPressed: () {
          onRetry();
        },
      )
    ],
  );
}
