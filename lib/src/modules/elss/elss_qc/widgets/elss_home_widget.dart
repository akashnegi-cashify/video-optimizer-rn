import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/part_selection_screen_qc.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../elss_trc/screens/part_selection_screen_trc.dart';
import '../l10n.dart';
import 'functionality_card.dart';

class ElssHomeWidget extends StatelessWidget {
  final bool isLoginFromQC;

  const ElssHomeWidget({super.key, required this.isLoginFromQC});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        _stackColourSheet(context, theme),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_28),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _userDetailsCard(context, theme, l10n),
            const SizedBox(height: Dimens.space_20),
            if (!isLoginFromQC)
              FunctionalityCard(
                cardLabel: l10n.techRefurbishmentCenter,
                cardIconPath: "assets/images/ic_qc.png",
                onTap: () {
                  CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                    if (!Validator.isNullOrEmpty(scannedData)) {
                      PartSelectionScreenTrcArguments args =
                          PartSelectionScreenTrcArguments(barcode: scannedData.trim());
                      Navigator.of(context).pushReplacementNamed(PartSelectionScreenTrc.route, arguments: args);
                    }
                  });
                },
              ),
            if (isLoginFromQC)
              FunctionalityCard(
                cardLabel: l10n.qualityCheck,
                cardIconPath: "assets/images/ic_trc.png",
                onTap: () {
                  CshMlScannerUtil().openScanner(
                    context,
                    onScanned: (scannedData, controller) {
                      _onBarcodeScanned(context, scannedData);
                    },
                  );
                },
              ),
          ]),
        )
      ],
    );
  }

  _onBarcodeScanned(BuildContext context, String scannedBarcode) {
    if (!Validator.isNullOrEmpty(scannedBarcode)) {
      Navigator.pop(context); // Close the scanner screen
      CshLoading().showLoading(context);
      Future.delayed(Duration(seconds: 1), () {
        if (context.mounted) {
          CshLoading().hideLoading(context);
          CshMlScannerUtil().openScanner(
            context,
            header: "Scan PQuote Id",
            scanFormatList: [BarcodeFormat.qrCode],
            bottomView: Padding(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshMediumOutlineButton(
                text: "Skip",
                onPressed: () {
                  _onSkipPQuoteId(context, scannedBarcode);
                },
              ),
            ),
            onScanned: (pQuoteId, controller) {
              PartSelectionScreenArguments args = PartSelectionScreenArguments(
                scannedBarcode: scannedBarcode.trim(),
                pQuoteId: pQuoteId.trim(),
              );
              Navigator.of(context).pushReplacementNamed(PartSelectionScreenQc.route, arguments: args);
            },
          );
        }
      });
    }
  }

  _stackColourSheet(BuildContext context, ThemeData theme) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.space_20),
          bottomRight: Radius.circular(Dimens.space_20),
        ),
      ),
    );
  }

  _userDetailsCard(BuildContext context, ThemeData theme, L10n l10n) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.space_8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _labelValueWidget(
              theme,
              l10n.name,
              (!Validator.isNullOrEmpty(UserDetails().userDetailsData?.firstName))
                  ? "${UserDetails().userDetailsData!.firstName}"
                  : ""),
          _labelValueWidget(
              theme,
              l10n.employeeId,
              (!Validator.isNullOrEmpty(UserDetails().userDetailsData?.uid))
                  ? "${UserDetails().userDetailsData!.uid}"
                  : "")
        ],
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:", style: theme.primaryTextTheme.labelLarge?.copyWith(color: theme.shadowColor)),
        const SizedBox(height: Dimens.space_2),
        Text(value, style: theme.primaryTextTheme.titleSmall),
      ],
    );
  }

  void _onSkipPQuoteId(BuildContext context, String scannedBarcode) {
    var theme = Theme.of(context);
    String? remarks;
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: StatefulBuilder(builder: (innerContext, setState) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Dimens.space_16),
                Text(
                  "Why skipping battery stress testing?",
                  style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                ),
                Divider(color: theme.dividerColor),
                const SizedBox(height: Dimens.space_16),
                CshTextFormField(
                  hintText: "Enter skip remarks",
                  onChanged: (value) {
                    setState(() {
                      remarks = value;
                    });
                  },
                ),
                const SizedBox(height: Dimens.space_16),
                Center(
                  child: CshMediumButton(
                    text: "Submit",
                    onPressed: Validator.isNullOrEmpty(remarks)
                        ? null
                        : () {
                            Navigator.pop(context); // Close the bottom sheet
                            PartSelectionScreenArguments args =
                                PartSelectionScreenArguments(scannedBarcode: scannedBarcode.trim(), remarks: remarks);
                            Navigator.of(context).pushReplacementNamed(PartSelectionScreenQc.route, arguments: args);
                          },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
