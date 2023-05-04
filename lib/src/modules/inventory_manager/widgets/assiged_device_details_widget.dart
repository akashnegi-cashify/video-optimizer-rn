import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/assigned_device_details.dart';

class AssignedDeviceDetailsWidget extends StatelessWidget {
  final AssignDeviceDetailsData? dataModel;
  final String? errorMessage;
  final bool isLoading;

  const AssignedDeviceDetailsWidget({
    Key? key,
    required this.isLoading,
    this.dataModel,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshShimmer(
      show: isLoading,
      child: CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.space_8),
          ),
          child: (!Validator.isNullOrEmpty(errorMessage))
              ? Center(
                  child: SizedBox(
                    height: Dimens.space_90,
                    child: Row(
                      children: [
                        const SizedBox.shrink(),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: theme.primaryTextTheme.headline4,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    if (!Validator.isNullOrEmpty(dataModel?.deviceBarcode)) ...[
                      _labelValueWidget(theme, l10n.deviceBarcode, dataModel!.deviceBarcode!),
                      const SizedBox(height: Dimens.space_8)
                    ],
                    if (!Validator.isNullOrEmpty(dataModel?.productName)) ...[
                      _labelValueWidget(theme, l10n.deviceName, dataModel!.productName!),
                      const SizedBox(height: Dimens.space_8)
                    ],
                    if (!Validator.isNullOrEmpty(dataModel?.engineerName)) ...[
                      _labelValueWidget(theme, l10n.engineerSName, dataModel!.engineerName!),
                      const SizedBox(height: Dimens.space_8)
                    ],
                    if (!Validator.isNullOrEmpty(dataModel?.lc)) ...[
                      _labelValueWidget(theme, l10n.location, dataModel!.lc!),
                      const SizedBox(height: Dimens.space_8)
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headline4,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
