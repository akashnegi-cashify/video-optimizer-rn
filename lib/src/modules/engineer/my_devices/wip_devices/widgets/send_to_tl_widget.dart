import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/send_to_tl_provider.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

import '../../../models/engineer_device_info.dart';

class SendToTLWidget extends StatelessWidget {
  final EngineerDeviceInfo deviceInfo;

  const SendToTLWidget({Key? key, required this.deviceInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(
      text: l10n.sendToTL,
      onPressed: () {
        CshLoading().showLoading(context);
        EngineerAPIService.listDeviceReturnReasons().listen((event) async {
          CshLoading().hideLoading(context);

          if (event != null && event.isSuccess == true && event.reasons != null && event.reasons!.isNotEmpty) {
            var dropDownItem = await _askForTheReasonOfReturn(deviceInfo, context, event.reasons!) as DropDownItem?;

            if (deviceInfo.deviceBarcode != null && dropDownItem?.id != null) {
              EngineerAPIService.sendToTL(deviceInfo.deviceBarcode!, dropDownItem!.id!).listen((event) {
                if (event == null) {
                  CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
                  return;
                }

                if (event.errorMsg != null) {
                  CshSnackBar.error(context: context, message: event.errorMsg!);
                  return;
                }

                if (event.isSuccess) {
                  CshSnackBar.success(context: context, message: l10n.deviceSentToTLSuccessfully);
                  Navigator.pop(context);
                  return;
                }

                CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
              }, onError: (error, stacktrace) {}, onDone: () {});
            }
          } else {
            CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
          }
        }).onError((error, stacktrace) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
        });
      },
    );
  }

  Future<dynamic> _askForTheReasonOfReturn(
      EngineerDeviceInfo deviceInfo, BuildContext context, Map<String, String> returnReasons) async {
    return await showDialog(
        useRootNavigator: false,
        builder: (context) {
          L10n l10n = L10n(context);

          return ChangeNotifierProvider(create: (context) {
            return SendToTLProvider();
          }, builder: (context, widget) {
            return Dialog(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CshTextNew.subTitle1(l10n.clickOnConfirmToSendTL),
                  const SizedBox(
                    height: Dimens.space_16,
                  ),
                  TitleValueRowWidget(title: l10n.deviceName, value: deviceInfo.productTitle ?? ""),
                  TitleValueRowWidget(title: l10n.deviceBarcode, value: deviceInfo.deviceBarcode ?? ""),
                  TitleValueRowWidget(title: l10n.color, value: deviceInfo.color ?? ""),
                  const SizedBox(
                    height: Dimens.space_8,
                  ),
                  CshDropDown(
                      hintText: l10n.selectAReasonToContinue,
                      selectedItem: Provider.of<SendToTLProvider>(context, listen: false).selectedReason,
                      items: returnReasons.map((key, value) => MapEntry(key, DropDownItem(key, value))).values.toList(),
                      onChanged: (DropDownItem item) {
                        Provider.of<SendToTLProvider>(context, listen: false).selectedReason = item;
                      }),
                  const SizedBox(
                    height: Dimens.space_16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CshMediumOutlineButton(
                        textColor: Theme.of(context).errorColor,
                        bgColor: Theme.of(context).errorColor,
                        text: l10n.cancel,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(
                        width: Dimens.space_30,
                      ),
                      Row(
                        children: [
                          CshMediumButton(
                            text: l10n.confirm,
                            onPressed: Provider.of<SendToTLProvider>(context, listen: true).selectedReason == null
                                ? null
                                : () => Navigator.of(context)
                                    .pop(Provider.of<SendToTLProvider>(context, listen: false).selectedReason),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ));
          });
        },
        context: context);
  }
}
