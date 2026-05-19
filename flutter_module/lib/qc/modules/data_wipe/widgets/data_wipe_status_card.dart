import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_status.dart';

class DataWipeStatusCard extends StatelessWidget {
  final int? statusCode;
  final String? status;

  const DataWipeStatusCard(this.statusCode, this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CshCard(
      child: Column(
        children: [
          const SizedBox(height: Dimens.space_32),
          _getImage(theme, context),
          const SizedBox(height: Dimens.space_20),
          CshTextNew.subTitle1(status ?? "No status found"),
        ],
      ),
    );
  }

  Widget _getImage(ThemeData theme, BuildContext context) {
    var status = DataWipeStatus.getStatus(statusCode);
    switch (status) {
      case DataWipeStatus.init:
        return Image.asset('assets/images/data_wipe_init.png',
            width: MediaQuery.of(context).size.width * 0.62, fit: BoxFit.fitWidth);
      case DataWipeStatus.success:
        return _getSuccessImage(theme);
      case DataWipeStatus.error:
        return Container(
          padding: const EdgeInsets.all(Dimens.space_16),
          decoration: BoxDecoration(
            color: theme.colorScheme.error.withAlpha(40),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 50, color: theme.colorScheme.error),
        );
    }
  }

  Widget _getSuccessImage(ThemeData theme) {
    CustomColors customColors = theme.extension<CustomColors>() as CustomColors;
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      decoration: BoxDecoration(
        color: customColors.successColor.withAlpha(40),
        shape: BoxShape.circle,
      ),
      child: Icon(FeatherIcons.check, size: 50, color: customColors.successColor),
    );
  }
}
