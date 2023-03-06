import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/elss_status_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_suggestion_widget.dart';

import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';
import '../providers/channel_option_provider.dart';
import '../screens/part_selection_screen_qc.dart';
import 'channel_option_modal_widget.dart';
import 'elss_device_details_widget.dart';

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
                  ElssDeviceDetailsWidget(
                    dataModel: widget.detailsDataModel?.deviceDetailsData,
                    gradeLabel: l10n.initialGrade,
                  ),
                  const SizedBox(height: Dimens.space_16),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.initialPlatformSuggestion,
                    dataModel: provider.channelOptionResponse?.channelOptionData?.initialChannelOption,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.yourSuggestion,
                    dataModel: provider.channelOptionResponse?.channelOptionData?.yourChannelSuggestion,
                    isCardElevated: true,
                    onCardSelected: () {
                      _showModalForYourSuggestion(
                        modalHeading: l10n.yourSuggestion,
                        onPna: () {
                          if (!Validator.isListNullOrEmpty(provider
                              .channelOptionResponse?.channelOptionData?.yourChannelSuggestion?.requestedParts)) {
                            Navigator.of(context).pop(true);
                            _onYourSuggestionPNAModal(l10n, theme);
                          } else {
                            CshSnackBar.error(
                              context: context,
                              message: l10n.noPartsAvailableForPna,
                              snackBarPosition: SnackBarPosition.TOP,
                            );
                          }
                        },
                        onDone: () {
                          Navigator.of(context).pop(true);
                          var dataMap = provider.getPostDataMapForElssOptionData(provider
                                  .channelOptionResponse?.channelOptionData?.yourChannelSuggestion?.requestedParts ??
                              []);
                          _submitElssAccept(
                            dataMap,
                            101,
                            isRubAllowed: provider
                                .channelOptionResponse?.channelOptionData?.yourChannelSuggestion?.isRubbingAllowed,
                          );
                        },
                      );
                    },
                  ),
                  if (!Validator.isListNullOrEmpty(provider.channelOptions)) ...[
                    const SizedBox(height: Dimens.space_20),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return ChannelSuggestionWidget(
                          title: l10n.channelSuggestion,
                          dataModel: provider.channelOptions![index],
                          onCardSelected: () {
                            _showModalForImages(
                              index,
                              modalHeading: l10n.channelSuggestion,
                              onPna: () {
                                if (!Validator.isListNullOrEmpty(provider.channelOptionResponse!.channelOptionData!
                                    .listOfChannelOption![index].requestedParts)) {
                                  Navigator.of(context).pop(true);
                                  _onPNAOptionModal(index, l10n, theme);
                                } else {
                                  CshSnackBar.error(
                                    context: context,
                                    message: l10n.noPartsAvailableForPna,
                                    snackBarPosition: SnackBarPosition.TOP,
                                  );
                                }
                              },
                              onDone: () {
                                Navigator.of(context).pop(true);
                                if (provider.channelOptions![index].optionId != null) {
                                  var dataMap = provider
                                      .getPostDataMapForElssOptionData(provider.channelOptions![index].requestedParts!);
                                  _submitElssAccept(
                                    dataMap,
                                    provider.channelOptions![index].optionId!,
                                    isRubAllowed: provider.channelOptions![index].isRubbingAllowed,
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                      itemCount: provider.channelOptions!.length,
                    )
                  ],
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.nonRepairSuggestion,
                    dataModel: provider.channelOptionResponse?.channelOptionData?.defaultChannelOption,
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
                //Reject ELSS option
                Expanded(
                  child: CshMediumOutlineButton(
                    text: l10n.reject,
                    onPressed: () {
                      _onRejectElss();
                    },
                    borderColor: theme.errorColor,
                    textColor: theme.errorColor,
                  ),
                ),
                const SizedBox(width: Dimens.space_20),
                //Retest ELSS
                Expanded(
                  child: CshMediumButton(
                    text: l10n.reset,
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(PartSelectionScreenQc.route, arguments: widget.scannedBarcode);
                    },
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
        dataModel: provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion,
        onDoneCallback: onDone,
        onPnaCallback: onPna,
      ),
    );
  }

  _showModalForImages(
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
        dataModel: provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index],
        onDoneCallback: onDone,
        onPnaCallback: onPna,
      ),
    );
  }

  _onRejectElss() {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.rejectElss(widget.scannedBarcode).then((value) {
      CshLoading().hideLoading(context);
      Navigator.pushReplacementNamed(
        context,
        ElssStatusScreen.routeName,
        arguments: ElssStatusScreenArg(elssStatus: ElssStatus.reject, barcode: widget.scannedBarcode),
      );
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _onYourSuggestionPNAModal(L10n l10n, ThemeData theme) {
    var provider = ChannelOptionProvider.of(context, listen: false);
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
                style: theme.primaryTextTheme.headline3,
              ),
            ),
            const SizedBox(height: Dimens.space_8),
            SizedBox(
              width: double.infinity,
              height: 400.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                itemBuilder: (context, indexing) {
                  return AddPartItemList(
                    dataModel: PartItemDataResponse(
                      provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!
                          .requestedParts![indexing].sku,
                      provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!
                          .requestedParts![indexing].partColour,
                      provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!
                          .requestedParts![indexing].partName,
                      isCardSelected: provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!
                          .requestedParts![indexing].isPnaSelected,
                    ),
                    onPartSelected: (bool data) {
                      provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!
                          .requestedParts![indexing].isPnaSelected = data;
                    },
                  );
                },
                separatorBuilder: (context, ind) {
                  return const SizedBox(
                    height: Dimens.space_8,
                  );
                },
                itemCount:
                    provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!.requestedParts!.length,
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
                if (provider.checkIsItemSelectedForPNA(
                  provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!.requestedParts!,
                )) {
                  _marPnaStatusToParts(
                      l10n, provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!.requestedParts!);
                } else {
                  Navigator.of(context).pop(true);
                  CshSnackBar.error(context: context, message: l10n.noPartSelectedForPna);
                }
              },
            )
          ],
        ),
      ),
    ).then(
      (value) {
        provider.removePNASelectedItem(
          provider.channelOptionResponse!.channelOptionData!.yourChannelSuggestion!.requestedParts!,
        );
      },
    );
  }

  _onPNAOptionModal(int index, L10n l10n, ThemeData theme) {
    var provider = ChannelOptionProvider.of(context, listen: false);
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
                style: theme.primaryTextTheme.headline3,
              ),
            ),
            const SizedBox(height: Dimens.space_8),
            SizedBox(
              width: double.infinity,
              height: 400.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                itemBuilder: (context, indexing) {
                  return AddPartItemList(
                    dataModel: PartItemDataResponse(
                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                          .requestedParts![indexing].sku,
                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                          .requestedParts![indexing].partColour,
                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                          .requestedParts![indexing].partName,
                      isCardSelected: provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                          .requestedParts![indexing].isPnaSelected,
                    ),
                    onPartSelected: (bool data) {
                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                          .requestedParts![indexing].isPnaSelected = data;
                    },
                  );
                },
                separatorBuilder: (context, ind) {
                  return const SizedBox(
                    height: Dimens.space_8,
                  );
                },
                itemCount: provider
                    .channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts!.length,
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
                if (provider.checkIsItemSelectedForPNA(
                    provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts!)) {
                  _marPnaStatusToParts(l10n,
                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts!);
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
      provider.removePNASelectedItem(
          provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts!);
    });
  }

  _marPnaStatusToParts(L10n l10n, List<ElssPart> dataList) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.markPNAStatus(widget.scannedBarcode, dataList).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: ElssStatusScreenArg(elssStatus: ElssStatus.pna, barcode: widget.scannedBarcode),
        );
      }
    }, onError: (error) {
      Navigator.of(context).pop(true);
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      CshLoading().hideLoading(context);
    });
  }

  _submitElssAccept(List<Map<String, dynamic>> dataList, int optionId, {bool? isRubAllowed}) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider
        .submitElssAcceptData(dataList, widget.scannedBarcode, optionId: optionId, isRubbingAllowed: isRubAllowed)
        .then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: ElssStatusScreenArg(elssStatus: ElssStatus.submit, barcode: widget.scannedBarcode),
        );
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      CshLoading().hideLoading(context);
    });
  }
}
