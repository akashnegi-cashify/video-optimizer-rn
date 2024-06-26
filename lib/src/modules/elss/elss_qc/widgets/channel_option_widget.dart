import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/elss_status_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/part_selection_screen_qc.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_suggestion_widget.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/reject_retest_reason_selection_modal.dart';

import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';
import '../providers/channel_option_provider.dart';
import 'channel_option_modal_widget.dart';
import 'elss_device_details_widget.dart';

const int _YOUR_SUGGESTION_OPTION_ID = 101;

class ChannelOptionWidget extends StatefulWidget {
  final String scannedBarcode;
  final ElssDeviceDetailsResponse? detailsDataModel;

  const ChannelOptionWidget(
    this.scannedBarcode, {
    Key? key,
    this.detailsDataModel,
  }) : super(key: key);

  @override
  State<ChannelOptionWidget> createState() => _ChannelOptionWidgetState();
}

class _ChannelOptionWidgetState extends State<ChannelOptionWidget> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ChannelOptionProvider.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElssDeviceDetailsWidget(dataModel: widget.detailsDataModel?.deviceDetailsData),
                  const SizedBox(height: Dimens.space_16),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.initialPlatformSuggestion,
                    dataModel: provider.initialChannelSuggestion,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.yourSuggestion,
                    dataModel: provider.yourChannelSuggestion,
                    isCardElevated: true,
                    onCardSelected: () {
                      _showModalForYourSuggestion(
                        modalHeading: l10n.yourSuggestion,
                        onPna: () => _onYourSuggestionPNAModal(l10n, theme, _YOUR_SUGGESTION_OPTION_ID, provider),
                        onDone: () {
                          Navigator.of(context).pop();
                          // TODO: remove this dataMap as it is not used by backend
                          var dataMap = provider
                              .getPostDataMapForElssOptionData(provider.yourChannelSuggestion?.requestedParts ?? []);
                          _submitElssAccept(dataMap, _YOUR_SUGGESTION_OPTION_ID);
                        },
                      );
                    },
                  ),
                  if (!Validator.isListNullOrEmpty(provider.otherChannelOptions)) ...[
                    const SizedBox(height: Dimens.space_20),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return ChannelSuggestionWidget(
                          title: l10n.channelSuggestion,
                          dataModel: provider.otherChannelOptions![index],
                          onCardSelected: () {
                            _showModalForOtherChannelOptions(
                              index,
                              modalHeading: l10n.channelSuggestion,
                              onPna: () => _onOtherChannelOptionsPNAModal(index, l10n, theme, provider),
                              onDone: () {
                                Navigator.of(context).pop(true);
                                if (provider.otherChannelOptions![index].optionId != null) {
                                  var dataMap = provider.getPostDataMapForElssOptionData(
                                      provider.otherChannelOptions![index].requestedParts!);
                                  _submitElssAccept(dataMap, provider.otherChannelOptions![index].optionId!);
                                }
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                      itemCount: provider.otherChannelOptions!.length,
                    )
                  ],
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.nonRepairSuggestion,
                    dataModel: provider.defaultChannelSuggestion,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimens.space_8),
        CshCard(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_20),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimens.space_8),
                topLeft: Radius.circular(Dimens.space_8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CshMediumOutlineButton(
                    text: l10n.reject,
                    onPressed: () => _onRejectElss(),
                    borderColor: theme.colorScheme.error,
                    textColor: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(width: Dimens.space_20),
                Expanded(
                  child: CshMediumButton(
                    text: l10n.reset,
                    onPressed: () => _onReset(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showModalForYourSuggestion({
    required String modalHeading,
    required Function() onDone,
    required Function() onPna,
  }) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    showCshBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      child: ChannelOptionModalWidget(
        modalHeading: modalHeading,
        dataModel: provider.yourChannelSuggestion,
        onDoneCallback: onDone,
        onPnaCallback: onPna,
      ),
    );
  }

  _showModalForOtherChannelOptions(
    int index, {
    required String modalHeading,
    required Function() onDone,
    required Function() onPna,
  }) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    showCshBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      child: ChannelOptionModalWidget(
        modalHeading: modalHeading,
        dataModel: provider.otherChannelOptions![index],
        onDoneCallback: onDone,
        onPnaCallback: onPna,
      ),
    );
  }

  _onRejectElss() {
    showRejectRetestBottomSheetModal(context, ReasonType.reject, widget.scannedBarcode);
  }

  _onReset() {
    showPopup(context,
        title: "Warning!!",
        desc: "All Progress will be lost. Are you sure you want to reset?",
        actions: [
          ComboButton(
              firstBtnText: "No",
              secondBtnText: "Yes",
              isFirstPrimary: false,
              firstBtnClick: () => Navigator.pop(context),
              secondBtnClick: () {
                Navigator.pop(context); // Dismiss the dialog
                String? deviceBarcode = widget.detailsDataModel?.deviceDetailsData?.deviceBarcode;
                PartSelectionScreenArguments args = PartSelectionScreenArguments(scannedBarcode: deviceBarcode ?? "");
                Navigator.of(context).pushReplacementNamed(
                  PartSelectionScreenQc.route,
                  arguments: args,
                );
              })
        ]);
  }

  // For now Retest Button is replaced with Reset
  _onRetestElss() {
    showRejectRetestBottomSheetModal(context, ReasonType.retest, widget.scannedBarcode);
  }

  _onYourSuggestionPNAModal(L10n l10n, ThemeData theme, int optionId, ChannelOptionProvider provider) {
    var repairableDevicePartList = provider.getDevicePartsForPna(provider.yourChannelSuggestion?.requestedParts);
    if (Validator.isTrue(repairableDevicePartList?.isEmpty)) {
      CshSnackBar.error(context: context, message: l10n.noPartsAvailableForPna, snackBarPosition: SnackBarPosition.TOP);
      return;
    }
    Navigator.of(context).pop();
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Text(
                l10n.selectPartsForPna,
                style: theme.primaryTextTheme.displaySmall,
              ),
            ),
            const SizedBox(height: Dimens.space_8),
            SizedBox(
              width: double.infinity,
              height: 400.0,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                  itemCount: repairableDevicePartList!.length,
                  itemBuilder: (context, index) {
                    var item = repairableDevicePartList[index];
                    return AddPartItemList(
                      dataModel: PartItemDataResponse(
                        item.sku,
                        item.partColour,
                        item.partName,
                        isCardSelected: item.isPnaSelected,
                        partQuantity: item.quantity,
                      ),
                      onPartSelected: (bool data) {
                        provider.updateYourChannelSuggestionPNA(data, item);
                      },
                    );
                  },
                  separatorBuilder: (context, ind) {
                    return const SizedBox(height: Dimens.space_8);
                  }),
            ),
            ComboButton(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_8, Dimens.space_16, 0.0),
              firstBtnText: l10n.cancel,
              secondBtnText: l10n.submit,
              isFirstPrimary: true,
              buttonType: ButtonType.mini,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                if (provider.checkIsItemSelectedForPNA(provider.yourChannelSuggestion!.requestedParts!)) {
                  _markPnaStatusToParts(l10n, provider.yourChannelSuggestion!.requestedParts!, optionId);
                } else {
                  Navigator.of(context).pop();
                  CshSnackBar.error(context: context, message: l10n.noPartSelectedForPna);
                }
              },
            )
          ],
        ),
      ),
    ).then(
      (value) {
        provider.removePNASelectedItem(provider.yourChannelSuggestion!.requestedParts!);
      },
    );
  }

  _onOtherChannelOptionsPNAModal(int index, L10n l10n, ThemeData theme, ChannelOptionProvider provider) {
    var channelOptionData = provider.otherChannelOptions![index];
    var repairableDevicePartList = provider.getDevicePartsForPna(channelOptionData.requestedParts);
    if (Validator.isTrue(repairableDevicePartList?.isEmpty)) {
      CshSnackBar.error(context: context, message: l10n.noPartsAvailableForPna, snackBarPosition: SnackBarPosition.TOP);
      return;
    }
    Navigator.of(context).pop();
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Text(
                l10n.selectPartsForPna,
                style: theme.primaryTextTheme.displaySmall,
              ),
            ),
            const SizedBox(height: Dimens.space_8),
            SizedBox(
              width: double.infinity,
              height: 400.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                itemBuilder: (context, indexing) {
                  var item = repairableDevicePartList[indexing];
                  return AddPartItemList(
                    dataModel: PartItemDataResponse(
                      item.sku,
                      item.partColour,
                      item.partName,
                      isCardSelected: item.isPnaSelected,
                      partQuantity: item.quantity,
                    ),
                    onPartSelected: (bool data) {
                      provider.updateOthersChannelSuggestionPNA(item, data, index);
                    },
                  );
                },
                separatorBuilder: (context, ind) {
                  return const SizedBox(
                    height: Dimens.space_8,
                  );
                },
                itemCount: repairableDevicePartList!.length,
              ),
            ),
            ComboButton(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_8, Dimens.space_16, 0.0),
              firstBtnText: l10n.cancel,
              secondBtnText: l10n.submit,
              isFirstPrimary: true,
              buttonType: ButtonType.mini,
              firstBtnClick: () {
                Navigator.of(context).pop(true);
              },
              secondBtnClick: () {
                if (provider.checkIsItemSelectedForPNA(provider.otherChannelOptions![index].requestedParts!)) {
                  _markPnaStatusToParts(
                    l10n,
                    provider.otherChannelOptions![index].requestedParts!,
                    provider.otherChannelOptions![index].optionId,
                  );
                } else {
                  Navigator.of(context).pop(true);
                  CshSnackBar.error(context: context, message: l10n.noPartSelectedForPna);
                }
              },
            )
          ],
        ),
      ),
    ).then((value) {
      provider.removePNASelectedItem(provider.otherChannelOptions![index].requestedParts!);
    });
  }

  _markPnaStatusToParts(L10n l10n, List<ElssPart> dataList, int? optionId) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.markPNAStatus(widget.scannedBarcode, dataList, optionId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        ElssStatusCompArguments args = ElssStatusCompArguments(
            arguments: ElssStatusScreenArg(elssStatus: ElssStatus.pna, barcode: widget.scannedBarcode));
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: args,
        );
      }
    }, onError: (error) {
      Navigator.of(context).pop(true);
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      CshLoading().hideLoading(context);
    });
  }

  _submitElssAccept(List<Map<String, dynamic>> dataList, int optionId) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitElssAcceptData(dataList, widget.scannedBarcode, optionId: optionId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        ElssStatusCompArguments args = ElssStatusCompArguments(
            arguments: ElssStatusScreenArg(elssStatus: ElssStatus.submit, barcode: widget.scannedBarcode));
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: args,
        );
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      CshLoading().hideLoading(context);
    });
  }
}
