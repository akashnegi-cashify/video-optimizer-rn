import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/return_part_data.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/providers/return_part_provider.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/widgets/title_value_row_widget.dart';

class ReturnPartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback? onRequestCompletion;
  final bool isRetrievedPartAssign;

  const ReturnPartButtonWidget({
    super.key,
    required this.partInfo,
    this.onRequestCompletion,
    this.isRetrievedPartAssign = false,
  });

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(
        text: l10n.return_,
        onPressed: () async {
          if (Validator.isTrue(partInfo.isBulk) || Validator.isTrue(partInfo.isService)) {
            returnPart(context, l10n, partInfo.partBarcode);
          } else {
            CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
              Navigator.pop(context); // Dismiss scanner screen
              returnPart(context, l10n, scannedData);
            });
          }
        });
  }

  returnPart(BuildContext context, L10n l10n, String? partBarcode) =>
      EngineerAPIService.getReturnReasonList().listen((event) async {
        if (event != null && event.reasons != null && event.reasons!.isNotEmpty) {
          askForTheReasonOfReturn(
            context,
            event.reasons!,
            onSubmit: (reasonDialogData) {
              Navigator.pop(context); // Dismiss reason dialog
              if (partInfo.deviceBarcode != null) {
                ReturnPartData data = ReturnPartData(
                  partBarcode,
                  partInfo.partId.toString(),
                  reasonDialogData.dropDownItem.id,
                  reasonDialogData.remarks,
                  partInfo.prId,
                  reasonDialogData.retrievedPartBarcode,
                );
                EngineerAPIService.returnPart(data).listen((event) {
                  if (event == null) {
                    _showSnackBar(context, l10n.somethingWentWrong, isError: true);
                    return;
                  }

                  if (event.errorMsg != null) {
                    _showSnackBar(context, event.errorMsg!, isError: true);
                    return;
                  }

                  if (onRequestCompletion != null) {
                    onRequestCompletion!();
                  }
                  _showSnackBar(context, l10n.partSentToReturn);
                }, onError: (error, stacktrace) {
                  _showSnackBar(context, ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong,
                      isError: true);
                });
              }
            },
          );
        } else {
          _showSnackBar(context, l10n.somethingWentWrong, isError: true);
        }
      }).onError((error, stacktrace) {
        String? errorMessage = ApiErrorHelper.getErrorMessage(error);
        _showSnackBar(context, errorMessage ?? l10n.somethingWentWrong, isError: true);
      });

  void askForTheReasonOfReturn(BuildContext context, List<String> returnReasons,
      {required Function(ReasonDialogData data) onSubmit}) async {
    final TextEditingController retrievedPartController = TextEditingController();
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        L10n l10n = L10n(context);
        return ChangeNotifierProvider(
          create: (_) => ReturnPartProvider(),
          builder: (context, widget) {
            var theme = Theme.of(context);
            var provider = Provider.of<ReturnPartProvider>(context);
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleValueRowWidget(title: l10n.deviceName, value: partInfo.deviceName ?? ""),
                    TitleValueRowWidget(title: l10n.deviceBarcode, value: partInfo.deviceBarcode ?? ""),
                    TitleValueRowWidget(title: l10n.partName, value: partInfo.partName ?? ""),
                    const SizedBox(height: Dimens.space_8),
                    CshDropDown(
                      hintText: l10n.chooseYourResponse,
                      selectedItem: provider.selectedReason,
                      items: returnReasons.map((e) => DropDownItem<String>(e, e)).toList(),
                      onChanged: (DropDownItem<String> item) {
                        provider.selectedReason = item;
                      },
                    ),
                    const SizedBox(height: Dimens.space_16),
                    CshTextFormField(
                      hintText: l10n.remarks,
                      onChanged: (remarks) {
                        provider.remarks = remarks;
                      },
                    ),
                    if (isRetrievedPartAssign)
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.space_16),
                        child: CshTextFormField(
                          readOnly: true,
                          controller: retrievedPartController,
                          hintText: l10n.retrievedPartBarcode,
                          onTap: () {
                            CshMlScannerUtil().openScanner(
                              context,
                              onScanned: (scannedData, _) {
                                Navigator.pop(context); // Dismiss scanner screen
                                retrievedPartController.text = scannedData;
                                provider.retrievedPartBarcode = scannedData;
                              },
                            );
                          },
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CshMediumOutlineButton(
                          textColor: theme.colorScheme.error,
                          bgColor: theme.colorScheme.error,
                          text: l10n.cancel,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: Dimens.space_30),
                        CshMediumButton(
                          text: l10n.confirm,
                          onPressed: provider.isEnabled(isRetrievedPartAssign)
                              ? () {
                                  var data = ReasonDialogData(
                                    provider.selectedReason!,
                                    provider.remarks,
                                    isRetrievedPartAssign ? provider.retrievedPartBarcode : null,
                                  );
                                  onSubmit(data);
                                }
                              : null,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      retrievedPartController.dispose();
    });
  }

  _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ThemeData theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var backgroundColor = customTheme.successColor;
    if (isError) {
      backgroundColor = theme.colorScheme.error;
    }
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 200,
        left: Dimens.space_8,
        right: Dimens.space_8,
      ),
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.onSecondary),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class ReasonDialogData {
  final DropDownItem<String> dropDownItem;
  final String? remarks;
  final String? retrievedPartBarcode;

  ReasonDialogData(this.dropDownItem, this.remarks, this.retrievedPartBarcode);
}
