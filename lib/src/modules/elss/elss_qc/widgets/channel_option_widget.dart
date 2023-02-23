import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/your_channel_suggestion.dart';
import '../../../../screens/barcode_scanner_screen.dart';
import '../../common_models/channel_option_response.dart';
import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';
import '../providers/channel_option_provider.dart';
import '../screens/part_selection_screen_qc.dart';
import 'channel_option_modal_widget.dart';
import 'channel_options_card_widget.dart';
import 'default_channel_widget.dart';
import 'elss_device_details_widget.dart';
import 'initial_or_default_option_widget.dart';

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
                  if (!Validator.isListNullOrEmpty(
                      provider.channelOptionResponse?.channelOptionData?.listOfChannelOption)) ...[
                    Text(l10n.channelOptions, style: theme.primaryTextTheme.headline4),
                    const SizedBox(height: Dimens.space_16),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return ChannelOptionCardWidget(
                          dataModel: provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index],
                          onCardTap: () {
                            _showModalForImages(
                              index,
                              onPna: () {
                                if (!Validator.isListNullOrEmpty(provider.channelOptionResponse!.channelOptionData!
                                    .listOfChannelOption![index].requestedParts)) {
                                  Navigator.of(context).pop(true);
                                  _onPNAOptionModal(index, l10n, theme);
                                } else {
                                  CshSnackBar.error(context: context, message: l10n.noPartsAvailableForPna);
                                }
                              },
                              onDone: () {
                                if (provider.checkIfImageIsAttachedToAllSkus(provider.channelOptionResponse!
                                    .channelOptionData!.listOfChannelOption![index].requestedParts!)) {
                                  Navigator.of(context).pop(true);
                                  if (provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                                          .optionId !=
                                      null) {
                                    var dataMap = provider.getPostDataMapForElssOptionData(provider
                                        .channelOptionResponse!
                                        .channelOptionData!
                                        .listOfChannelOption![index]
                                        .requestedParts!);
                                    _submitElssAccept(
                                      dataMap,
                                      provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index]
                                          .optionId!,
                                      isRubAllowed: provider.channelOptionResponse!.channelOptionData!
                                          .listOfChannelOption![index].isRubbingAllowed,
                                    );
                                    Logger.debug('mydebug------_ChannelOptionWidgetState.build', [dataMap]);
                                  }
                                } else {
                                  CshSnackBar.error(
                                    context: context,
                                    message: l10n.attachImageEverySku,
                                    snackBarPosition: SnackBarPosition.TOP,
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
                      itemCount: provider.channelOptionResponse!.channelOptionData!.listOfChannelOption!.length,
                    )
                  ],
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.previousSuggestion,
                    dataModel: provider.channelOptionResponse?.channelOptionData?.initialChannelOption,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.yourChannelOption,
                    dataModel: provider.channelOptionResponse?.channelOptionData?.yourChannelSuggestion,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  ChannelSuggestionWidget(
                    title: l10n.defaultChannelOption,
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

  _showModalForImages(
    int index, {
    Function()? onDone,
    Function()? onPna,
  }) {
    var provider = ChannelOptionProvider.of(context, listen: false);
    showCshBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      child: ChannelOptionModalWidget(
        dataModel: provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index],
        onDoneCallback: onDone,
        onPnaCallback: onPna,
      ),
    ).then((value) {
      if (!Validator.isListNullOrEmpty(
          provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts)) {
        provider.removeAttachedImageOverBack(
            provider.channelOptionResponse!.channelOptionData!.listOfChannelOption![index].requestedParts!);
      }
    });
  }

  _onRejectElss() {
    var provider = ChannelOptionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.rejectElss(widget.scannedBarcode).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Elss Rejected Successfully!!!");
      Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
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
                separatorBuilder: (context, index) {
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
        CshSnackBar.success(context: context, message: l10n.pnaStatusAppliedToSelectedParts);
        Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
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
        CshSnackBar.success(context: context, message: "Elss Submitted Successfully!!");
        Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
      }
    }, onError: (error) {
      Navigator.of(context).pop(true);
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      CshLoading().hideLoading(context);
    });
  }
}
