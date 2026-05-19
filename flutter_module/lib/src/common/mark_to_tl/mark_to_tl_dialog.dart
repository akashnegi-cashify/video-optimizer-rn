import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/mark_to_tl/mark_to_tl_reasons_response.dart';
import 'package:flutter_trc/src/common/mark_to_tl/mark_to_tl_service.dart';

/// Shows a dialog to select a reason for marking a device to TL.
/// Fetches reasons from the API, then shows a dropdown dialog.
/// Returns the selected [MarkToTlReason] or null if cancelled.
Future<MarkToTlReason?> showMarkToTlDialog(BuildContext context) async {
  CshLoading().showLoading(context);

  List<MarkToTlReason>? reasons;
  String? errorMessage;

  try {
    await MarkToTlService.getReasons().listen((event) {
      if (!Validator.isListNullOrEmpty(event?.responseData)) {
        reasons = event!.responseData;
      } else {
        errorMessage = "Failed to load reasons";
      }
    }, onError: (error) {
      errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
    }).asFuture();
  } catch (e) {
    errorMessage = e.toString();
  }

  if (!context.mounted) return null;
  CshLoading().hideLoading(context);

  if (errorMessage != null || reasons == null || reasons!.isEmpty) {
    CshSnackBar.error(context: context, message: errorMessage ?? "No reasons available");
    return null;
  }

  return showDialog<MarkToTlReason>(
    context: context,
    useRootNavigator: false,
    builder: (dialogContext) {
      DropDownItem? selectedItem;
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space_16,
                vertical: Dimens.space_16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CshTextNew.subTitle1("Select a reason to continue"),
                  const SizedBox(height: Dimens.space_16),
                  StatefulBuilder(
                    builder: (context, setDropdownState) {
                      return CshDropDown(
                        hintText: "Select Reason",
                        selectedItem: selectedItem,
                        items: reasons!.map((r) => DropDownItem(r.id.toString(), r.reason ?? '')).toList(),
                        onChanged: (DropDownItem item) {
                          setDropdownState(() {
                            selectedItem = item;
                          });
                          // Also update the parent StatefulBuilder for button state
                          setState(() {});
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Dimens.space_16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CshMediumOutlineButton(
                        textColor: Theme.of(context).colorScheme.error,
                        bgColor: Theme.of(context).colorScheme.error,
                        text: "Cancel",
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: Dimens.space_30),
                      CshMediumButton(
                        text: "Submit",
                        onPressed: selectedItem == null
                            ? null
                            : () {
                                final selected = reasons!.firstWhere(
                                  (r) => r.id.toString() == selectedItem!.id,
                                );
                                Navigator.of(context).pop(selected);
                              },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
