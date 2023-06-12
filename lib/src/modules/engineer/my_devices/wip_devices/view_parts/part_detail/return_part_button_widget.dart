import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/return_part_data.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/providers/return_part_provider.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/widgets/title_value_row_widget.dart';
import '../../../../../../screens/barcode_scanner_screen.dart';

class ReturnPartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback? onRequestCompletion;

  const ReturnPartButtonWidget({Key? key, required this.partInfo, this.onRequestCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(
        text: l10n.return_,
        onPressed: () async {
          if (Validator.isTrue(partInfo.isBulk) || Validator.isTrue(partInfo.isService)) {
            returnPart(context, l10n, partInfo.partBarcode);
          } else {
            Navigator.pushNamed(context, BarcodeScanWidget.route, arguments: (String barcode) {
              returnPart(context, l10n, barcode);
            });
          }
        });
  }

  returnPart(BuildContext context, L10n l10n, String? partBarcode) =>
      EngineerAPIService.getReturnReasonList().listen((event) async {
        if (event != null && event.isSuccess == true && event.reasons != null && event.reasons!.isNotEmpty) {
          var reasonDialogData = await askForTheReasonOfReturn(context, event.reasons!) as ReasonDialogData?;

          if (partInfo.deviceBarcode != null && reasonDialogData != null) {
            ReturnPartData data = ReturnPartData(partBarcode, partInfo.partId.toString(),
                reasonDialogData.dropDownItem.id, reasonDialogData.remarks, partInfo.prId);
            EngineerAPIService.returnPart(data).listen((event) {
              if (event == null) {
                CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
                return;
              }

              if (event.errorMsg != null) {
                CshSnackBar.error(context: context, message: event.errorMsg!);
                return;
              }

              if (event.isSuccess) {
                if (onRequestCompletion != null) {
                  onRequestCompletion!();
                }
                CshSnackBar.success(context: context, message: l10n.partSentToReturn);
                return;
              }

              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
            }, onError: (error, stacktrace) {
              CshSnackBar.error(
                  context: context, message: ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
            }, onDone: () {
              Navigator.pop(context);
            });
          }
        } else {
          CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
        }
      }).onError((error, stacktrace) {
        CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
      });

  Future<dynamic> askForTheReasonOfReturn(BuildContext context, List<String> returnReasons) async {
    final TextEditingController controller = TextEditingController();
    return await showDialog(
            useRootNavigator: false,
            builder: (context) {
              L10n l10n = L10n(context);

              return ChangeNotifierProvider(create: (context) {
                return ReturnPartProvider();
              }, builder: (context, widget) {
                return Dialog(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleValueRowWidget(title: l10n.deviceName, value: partInfo.deviceName ?? ""),
                      TitleValueRowWidget(title: l10n.deviceBarcode, value: partInfo.deviceBarcode ?? ""),
                      TitleValueRowWidget(title: l10n.partName, value: partInfo.partName ?? ""),
                      const SizedBox(
                        height: Dimens.space_8,
                      ),
                      CshDropDown(
                          hintText: l10n.chooseYourResponse,
                          selectedItem: Provider.of<ReturnPartProvider>(context, listen: false).selectedReason,
                          items: returnReasons.map((e) => DropDownItem<String>(e, e)).toList(),
                          onChanged: (DropDownItem<String> item) {
                            Provider.of<ReturnPartProvider>(context, listen: false).selectedReason = item;
                          }),
                      const SizedBox(
                        height: Dimens.space_16,
                      ),
                      CshTextFormField(controller: controller, hintText: l10n.remarks),
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
                                onPressed: Provider.of<ReturnPartProvider>(context, listen: true).selectedReason == null
                                    ? null
                                    : () => Navigator.of(context).pop(ReasonDialogData(
                                        Provider.of<ReturnPartProvider>(context, listen: false).selectedReason!,
                                        controller.text)),
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
            context: context)
        .whenComplete(() => controller.dispose());
  }
}

class ReasonDialogData {
  final DropDownItem<String> dropDownItem;
  final String remarks;

  ReasonDialogData(this.dropDownItem, this.remarks);
}
