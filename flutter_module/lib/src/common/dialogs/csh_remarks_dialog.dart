import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

void showRemarksDialog(BuildContext context, {required Function(String? remarks) onProceed}) {
  String? remarks;
  showCshBottomSheet(
    isDismissible: false,
    context: context,
    child: Builder(builder: (innerContext) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(innerContext).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space_20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CshTextNew.subTitle1("Enter Remarks (Optional)"),
              const SizedBox(height: Dimens.space_16),
              CshTextFormField(
                hintText: "Enter Remarks",
                maxLines: 2,
                onChanged: (value) {
                  remarks = value;
                },
              ),
              const SizedBox(height: Dimens.space_16),
              ComboButton(
                  firstBtnText: "Skip",
                  secondBtnText: "Submit",
                  firstBtnClick: () {
                    onProceed(remarks);
                  },
                  secondBtnClick: () {
                    onProceed(remarks);
                  }),
            ],
          ),
        ),
      );
    }),
  );
}
