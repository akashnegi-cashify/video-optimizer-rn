import 'package:calculator_ui/calculator_ui.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/resources/pii_service.dart';

class PiiInfoWidget extends StatelessWidget {
  final String piiValue;
  final TextStyle? style;

  const PiiInfoWidget(this.piiValue, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Text(
        piiValue,
        style: style?.copyWith(decoration: TextDecoration.underline, color: theme.primaryColor),
      ),
    );
  }

  _onTap(BuildContext context) {
    CshLoading().showLoading(context);
    PiiService.getPiiInformation(piiValue).listen((event) {
      CshLoading().hideLoading(context);
      if (!Validator.isNullOrEmpty(event?.data)) {
        _showPopup(context, event!.data!);
      } else {
        CshSnackBar.error(context: context, message: "Couldn't decrypt this value");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
    });
  }

  _showPopup(BuildContext context, String value) {
    showAlertDialog(
      context,
      title: "Pii Value",
      desc: value,
      onPosBtnPressed: (_) {
        Navigator.pop(context);
      },
    );
  }
}
