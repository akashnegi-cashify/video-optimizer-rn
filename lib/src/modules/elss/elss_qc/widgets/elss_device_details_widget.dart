import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/stress_testing_value_type.dart';

import '../../common_models/elss_device_details_response.dart';
import '../l10n.dart';

class ElssDeviceDetailsWidget extends StatelessWidget {
  final DeviceDetailsData? dataModel;

  const ElssDeviceDetailsWidget({super.key, this.dataModel});

  List<Widget> _getDetailList(ThemeData theme, L10n l10n) {
    List<Widget> list = [];
    if (dataModel != null) {
      if (!Validator.isNullOrEmpty(dataModel!.deviceName!)) {
        list.add(_labelAndValueWidget(theme, l10n.deviceName, dataModel!.deviceName!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.deviceRepairType)) {
        list.add(_labelAndValueWidget(theme, l10n.repairType, dataModel!.deviceRepairType!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.deviceBarcode)) {
        list.add(_labelAndValueWidget(theme, l10n.deviceBarcode, dataModel!.deviceBarcode!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.deviceColor)) {
        list.add(_labelAndValueWidget(theme, l10n.deviceColour, dataModel!.deviceColor!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.imei)) {
        list.add(_labelAndValueWidget(theme, l10n.deviceImei, dataModel!.imei!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.deviceGrade)) {
        list.add(_labelAndValueWidget(theme, l10n.currentGrade, dataModel!.deviceGrade!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.suggestedGrade)) {
        list.add(_labelAndValueWidget(theme, l10n.suggestedGrade, dataModel!.suggestedGrade!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.suggestedChannel)) {
        list.add(_labelAndValueWidget(theme, l10n.suggestedChannel, dataModel!.suggestedChannel!));
      }

      if (!Validator.isNullOrEmpty(dataModel?.serialNumber)) {
        list.add(_labelAndValueWidget(theme, l10n.serialNumber, dataModel!.serialNumber!));
      }

      if (!Validator.isListNullOrEmpty(dataModel?.stockTags)) {
        list.add(_labelAndValueWidget(theme, l10n.tags, dataModel!.stockTags!.join(" | ")));
      }

      if (dataModel?.stressTestingResult != null) {
        var stressTestingResult = StressTestingValueType.fromValue(dataModel!.stressTestingResult!);
        list.add(_labelAndValueWidget(
          theme,
          l10n.stressTesting,
          stressTestingResult.label,
          isValueNegative: stressTestingResult == StressTestingValueType.failed,
        ));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var list = _getDetailList(theme, l10n);
    return CshCard(
      radius: CshRadius.rad4,
      padding: EdgeInsets.all(Dimens.space_16),
      elevation: CardElevation.dimen_10,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5,
          crossAxisSpacing: Dimens.space_16,
          mainAxisSpacing: Dimens.space_16,
        ),
        itemCount: list.length,
        itemBuilder: (_, index) {
          return list[index];
        },
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value, {bool isValueNegative = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.primaryTextTheme.labelLarge?.copyWith(color: theme.shadowColor),
        ),
        const SizedBox(height: Dimens.space_6),
        Text(
          value,
          style: theme.primaryTextTheme.titleSmall?.copyWith(color: isValueNegative ? theme.colorScheme.error : null),
        ),
      ],
    );
  }
}
