import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/part_selection_screen_qc.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../../elss_trc/screens/part_selection_screen_trc.dart';
import '../l10n.dart';
import 'functionality_card.dart';

class ElssHomeWidget extends StatelessWidget {
  final bool isLoginFromQC;

  const ElssHomeWidget({
    Key? key,
    required this.isLoginFromQC,
  }) : super(key: key);

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
            const SizedBox(
              height: Dimens.space_20,
            ),
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
                      if (!Validator.isNullOrEmpty(scannedData)) {
                        PartSelectionScreenArguments args =
                            PartSelectionScreenArguments(scannedBarcode: scannedData.trim());
                        Navigator.of(context).pushReplacementNamed(
                          PartSelectionScreenQc.route,
                          arguments: args,
                        );
                      }
                    },
                  );
                },
              ),
          ]),
        )
      ],
    );
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
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.space_8),
        ),
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
        Text("$label:", style: theme.primaryTextTheme.overline?.copyWith(color: theme.shadowColor)),
        const SizedBox(height: Dimens.space_2),
        Text(value, style: theme.primaryTextTheme.subtitle2),
      ],
    );
  }
}
