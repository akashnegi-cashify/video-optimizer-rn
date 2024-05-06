import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n.dart';

void showUpdateImeiDialog(
  BuildContext context,
  List<String> scannedList,
  String? matchedImei, {
  required VoidCallback onRescan,
  required Function(String? updatedImei, bool? isImeiAvailable, String fileUrl, bool isAutoApproved) onUpdateImei,
}) {
  scannedList.removeWhere((element) => element == matchedImei);
  List<DropDownItem>? imeiDropDownList;
  for (var element in scannedList) {
    if (element != matchedImei) {
      imeiDropDownList ??= [];
      imeiDropDownList.add(DropDownItem(element, element));
    }
  }

  DropDownItem? selectedImei;
  bool? isImeiAvailable;

  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  showCshBottomSheet(
    context: context,
    child: StatefulBuilder(builder: (_, setState) {
      return Container(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew.h3(l10n.updateMissingImei),
            const SizedBox(height: Dimens.space_16),
            Text(
              l10n.imeiUpdateDescription,
              style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.matchedImei, isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle1(matchedImei ?? "NA"),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space_12),
            if (!Validator.isListNullOrEmpty(imeiDropDownList))
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.imei2, isPrimary: false)),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: CshDropDown(
                      items: imeiDropDownList,
                      hintText: l10n.selectCorrectImei,
                      selectedItem: selectedImei,
                      onChanged: (DropDownItem? value) {
                        setState(() {
                          selectedImei = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: Dimens.space_8),
            CshCheckbox(
              title: Text(l10n.imeiNotAvailable, style: theme.primaryTextTheme.titleMedium),
              visualDensity: VisualDensity.comfortable,
              onChanged: (value) {
                isImeiAvailable = value ?? false;
              },
            ),
            const SizedBox(height: Dimens.space_24),
            CshMediumOutlineButton(
              text: l10n.reScan,
              onPressed: () {
                Navigator.pop(context); // close dialog
                onRescan();
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: l10n.update,
              onPressed: () {
                if (scannedList.length > 1 && selectedImei == null) {
                  CshSnackBar.error(
                      context: context, message: "Please select IMEI 2", snackBarPosition: SnackBarPosition.TOP);
                  return;
                }

                ImagePicker().pickImage(source: ImageSource.camera, requestFullMetadata: false).then((value) {
                  if (value != null) {
                    Navigator.pop(context); // close dialog
                    onUpdateImei(selectedImei?.label, isImeiAvailable, value.path,
                        (scannedList.length > 1 && selectedImei != null));
                  }
                });
              },
            ),
          ],
        ),
      );
    }),
  );
}
