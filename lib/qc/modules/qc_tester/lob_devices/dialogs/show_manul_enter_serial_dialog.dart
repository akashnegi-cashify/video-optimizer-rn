import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

void showManualEnterSerialNo(BuildContext context, {required Function(String serialNo) onSerialNoEntered}) {
  String serialNo = '';

  showDialog(
    context: context,
    builder: (_) {
      var theme = Theme.of(context);
      return AlertDialog(
        title: CshTextNew.h3("Enter Serial No"),
        contentPadding: EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, Dimens.space_8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Need an Image for approval",
              style: theme.primaryTextTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: Dimens.space_8),
            CshTextFormField(
              hintText: 'Enter Serial No',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                serialNo = value;
              },
            ),
          ],
        ),
        actions: [
          ComboButton(
            firstBtnText: "Cancel",
            secondBtnText: "Submit",
            buttonType: ButtonType.mini,
            padding: EdgeInsets.fromLTRB(Dimens.space_8, 0, Dimens.space_8, Dimens.space_16),
            firstBtnClick: () {
              Navigator.pop(context);
            },
            secondBtnClick: () {
              if (serialNo.isEmpty) {
                CshSnackBar.error(context: context, message: "Please enter serial no");
                return;
              }
              onSerialNoEntered(serialNo);
            },
          ),
        ],
      );
    },
  );
}
