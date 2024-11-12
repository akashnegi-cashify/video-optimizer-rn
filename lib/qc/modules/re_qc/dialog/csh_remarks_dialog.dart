import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

void showRemarksDialog(BuildContext context,
    {required Function(String? remarks) onProceed, required Function(String? remarks) onMarkFail}) {
  String? remarks;
  String? remarksError;
  showCshBottomSheet(
    isDismissible: false,
    context: context,
    child: StatefulBuilder(builder: (innerContext, setState) {
      var theme = Theme.of(innerContext);
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(innerContext).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space_20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CshTextNew.subTitle1("Enter Remarks"),
              const SizedBox(height: Dimens.space_16),
              CshTextFormField(
                  hintText: "Enter Remarks",
                  errorText: remarksError,
                  maxLines: 2,
                  onChanged: (value) {
                    remarks = value;
                  }),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Expanded(
                    child: CshBigButton(
                      text: "Mark Fail",
                      bgColor: theme.colorScheme.error,
                      textColor: theme.colorScheme.surface,
                      onPressed: () {
                        if (Validator.isNullOrEmpty(remarks)) {
                          setState(() {
                            remarksError = "Please add remarks to mark-fail";
                          });
                          return;
                        }
                        onMarkFail(remarks);
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.space_16),
                  Expanded(child: CshBigButton(text: "Submit", onPressed: () => onProceed(remarks))),
                ],
              ),
            ],
          ),
        ),
      );
    }),
  );
}
