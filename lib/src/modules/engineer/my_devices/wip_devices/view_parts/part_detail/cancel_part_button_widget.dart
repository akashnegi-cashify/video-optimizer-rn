import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/dialog_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

class CancelPartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback onRequestCompletion;

  const CancelPartButtonWidget({Key? key, required this.partInfo, required this.onRequestCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshMediumOutlineButton(
      text: l10n.cancel,
      onPressed: () {
        context.showConfirmationDialog(l10n.clickOnConfirmToCancel, negativeButtonData: (BuildContext context) {
          return ButtonData(() {
            Navigator.pop(context);
          }, l10n.cancel);
        }, positiveButtonData: (BuildContext context) {
          return ButtonData(() {
            EngineerAPIService.cancelPart(partInfo.prId!).listen((event) {
              Navigator.pop(context);

              if (event == null) {
                CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
                return;
              }
              if (event.errorMsg != null) {
                CshSnackBar.error(context: context, message: event.errorMsg!);
                return;
              }

              CshSnackBar.success(context: context, message: l10n.cancelPartRequestSuccess(partInfo.partName));
            }, onDone: () {
              onRequestCompletion();
            }, onError: (error, stackTrace) {
              Navigator.pop(context);
              CshSnackBar.error(
                  context: context, message: ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
            });
          }, l10n.confirm);
        });
      },
    );
  }
}
