import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../../screens/barcode_scanner_screen.dart';
import '../../common_models/part_device_list.dart';
import '../../common_resources/elss_action.dart';
import '../l10n.dart';
import '../providers/elss_provider_qc.dart';
import '../screens/add_part_screen_qc.dart';
import '../screens/allowed_option_screen.dart';
import 'discard_modal_widget.dart';
import 'elss_device_details_widget.dart';
import 'elss_part_widget.dart';
import 'elss_pna_modal_widget_qc.dart';
import 'option_not_allowed_modal_widget.dart';

class PartSelectionWidget extends StatefulWidget {
  final String barcode;

  const PartSelectionWidget({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  State<PartSelectionWidget> createState() => _PartSelectionWidgetState();
}

class _PartSelectionWidgetState extends State<PartSelectionWidget> {
  bool _isRubbingApplicable = false;

  List<PartItemDataResponse> additionalRequiredPartList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ELssProviderQc.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.space_8),
                  child: ElssDeviceDetailsWidget(dataModel: provider.elssDeviceDetails?.deviceDetailsData),
                ),
                const SizedBox(height: Dimens.space_20),
                if (provider.elssDeviceDetails?.deviceDetailsData?.partAdditionAllowed ?? false)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                      child: CshIconButton(
                        text: l10n.addParts,
                        onPressed: () async {
                          var data =
                              await Navigator.of(context).pushNamed(AddPartScreenQc.route, arguments: widget.barcode);
                          if ((data is List<PartItemDataResponse>?) && !Validator.isListNullOrEmpty(data)) {
                            for (var element in data!) {
                              Logger.debug('mydebug------_PartSelectionWidgetState.build', [element.toJson()]);
                            }
                            provider.addNewPartsFromAddParts(data);
                          }
                        },
                        prefixIcon: CshIcon(
                          FeatherIcons.plus,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                if (!Validator.isListNullOrEmpty(provider.elssPartList)) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                    child: Text(l10n.deviceParts, style: theme.primaryTextTheme.headline4),
                  ),
                  const SizedBox(height: Dimens.space_4),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return ElssPartWidget(
                        key: const Key("Master_List"),
                        onImageUploadCallback: (int imageIndex, String s3Url) {},
                        indexData: provider.elssPartList[index].elssPartId ?? -1,
                        onPartRemoved: (int id) {
                          provider.removeExternalAddedPart(id);
                        },
                        dataModel: provider.elssPartList[index],
                        onNotRequiredSelected: () {
                          provider.searchItemDataUpdate(
                            provider.elssPartList[index].elssPartId!,
                            action: ElssAction.NOT_REQUIRED.value,
                            actionConstant: (provider.elssPartActionResponse?.actionsData?.notRequired != null)
                                ? provider.elssPartActionResponse!.actionsData!.notRequired!
                                : -99,
                          );
                        },
                        onRequiredSelected: () {
                          provider.searchItemDataUpdate(
                            provider.elssPartList[index].elssPartId!,
                            action: ElssAction.REPAIRABLE.value,
                            actionConstant: (provider.elssPartActionResponse?.actionsData?.required != null)
                                ? provider.elssPartActionResponse!.actionsData!.required!
                                : -99,
                          );
                        },
                      );
                    },
                    itemCount: provider.elssPartList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                  ),
                ] else
                  const SizedBox(height: Dimens.space_20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
          child: GestureDetector(
            onTap: () {
              _isRubbingApplicable = !_isRubbingApplicable;
              provider.isRubbingApplicable = _isRubbingApplicable;
              setState(() {});
            },
            child: CshCard(
              padding: EdgeInsets.zero,
              radius: CshRadius.rad4,
              elevation: CardElevation.dimen_10,
              child: SizedBox(
                width: double.infinity,
                height: Dimens.space_60,
                child: Row(
                  children: [
                    CshCheckbox(
                      isSelected: _isRubbingApplicable,
                    ),
                    Text(
                      l10n.deviceRubbing,
                      style: theme.primaryTextTheme.overline,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimens.space_8),
        CshCard(
          radius: CshRadius.none,
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.space_6),
                topRight: Radius.circular(Dimens.space_6),
              ),
            ),
            child: _bottomHandlingButtons(
              l10n,
              theme,
              onDiscard: () {
                _showOnDiscardModalBottomSheet();
              },
              onPNA: provider.elssPartList.isEmpty
                  ? () {
                      CshSnackBar.error(
                        context: context,
                        message: l10n.noPartsAvailableForPna,
                        snackBarPosition: SnackBarPosition.TOP,
                      );
                    }
                  : () {
                      _onPnaOptionModal(l10n);
                    },
              onAccept: () {
                _submitDataForPartsLogic(l10n);
              },
            ),
          ),
        ),
      ],
    );
  }

  _showOnDiscardModalBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.space_8),
          topRight: Radius.circular(Dimens.space_8),
        ),
      ),
      builder: (BuildContext innerContext) {
        return DiscardModalWidget(
          onRejectCallback: () {
            Navigator.of(context).pop(true);
            _onRejectElss();
          },
          onRetestCallback: () {
            Navigator.of(context).pop(true);
            _onRetestingElss();
          },
        );
      },
    );
  }

  _onRejectElss() {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.rejectElss(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Elss Rejected Successfully!!!");
        Navigator.of(context).pushNamedAndRemoveUntil(BarcodeScanWidget.route, (route) => false);
      } else {
        CshSnackBar.error(context: context, message: "Something Went Wrong!!");
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _onRetestingElss() {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.retestElss(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Moved to Retesting successfully!!");
        Navigator.of(context).pushNamedAndRemoveUntil(BarcodeScanWidget.route, (route) => false);
      } else {
        CshSnackBar.error(context: context, message: "Something went wrong!!");
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _bottomHandlingButtons(
    L10n l10n,
    ThemeData theme, {
    Function()? onDiscard,
    Function()? onPNA,
    Function()? onAccept,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CshMediumOutlineButton(
                text: l10n.discard,
                textColor: theme.errorColor,
                borderColor: theme.errorColor,
                onPressed: () {
                  if (onDiscard != null) {
                    onDiscard();
                  }
                },
              ),
            ),
            const SizedBox(width: Dimens.space_26),
            Expanded(
              child: CshMediumOutlineButton(
                text: l10n.pna,
                textColor: theme.primaryColor,
                borderColor: theme.primaryColor,
                onPressed: () {
                  if (onPNA != null) {
                    onPNA();
                  }
                },
              ),
            )
          ],
        ),
        const SizedBox(height: Dimens.space_14),
        SizedBox(
          width: double.infinity,
          child: CshMediumButton(
            text: l10n.accept,
            onPressed: () {
              if (onAccept != null) {
                onAccept();
              }
            },
          ),
        )
      ],
    );
  }

  _onPnaOptionModal(L10n l10n) {
    var provider = ELssProviderQc.of(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: ElssPnaModalWidgetQC(
        arePartsAdded: (!Validator.isListNullOrEmpty(provider.elssPartList)),
        listOfSelectedParts: provider.elssPartList,
        onCardSelectedCallback: (int index, bool data) {
          provider.elssPartList[index].isPnaSelected = data;
        },
        onSubmitCallback: (Validator.isListNullOrEmpty(provider.elssPartList))
            ? () async {
                var data = await Navigator.of(context).pushNamed(AddPartScreenQc.route, arguments: widget.barcode);
                if ((data is List<PartItemDataResponse>?) && !Validator.isListNullOrEmpty(data)) {
                  for (var element in data!) {
                    Logger.debug('mydebug------_PartSelectionWidgetState.build', [element.toJson()]);
                  }
                  provider.addNewPartsFromAddParts(data);
                }
              }
            : () {
                if (provider.checkIsItemSelectedForPNA()) {
                  _marPnaStatusToParts(l10n);
                } else {
                  Navigator.of(context).pop(true);
                  CshSnackBar.error(
                      context: context, message: l10n.checkMarkPartForPna, snackBarPosition: SnackBarPosition.TOP);
                }
              },
      ),
    ).then((value) {
      provider.removePNASelectedItem();
    });
  }

  _submitDataForPartsLogic(L10n l10n) {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitPartsForLogic(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(
            context: context,
            message: l10n.partsSubmittedSuccessfully,
            duration: SnackBarDuration.SHORT,
            snackBarPosition: SnackBarPosition.TOP);
        if (provider.submitPatsLogicData?.data?.optionsAllowed != null &&
            provider.submitPatsLogicData!.data!.optionsAllowed == true) {
          AllowedOptionScreeArguments args =
              AllowedOptionScreeArguments(widget.barcode, detailsDataModel: provider.elssDeviceDetails);

          Navigator.of(context).pushReplacementNamed(AllowedOptionScreen.route, arguments: args);
        } else {
          _showOptionNotAllowedModal(l10n);
        }
      } else {
        CshSnackBar.error(context: context, message: "Something Went Wrong!!");
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _marPnaStatusToParts(L10n l10n) {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.markPNAStatus(widget.barcode).then((value) {
      if (value) {
        CshSnackBar.success(context: context, message: l10n.pnaStatusAppliedToSelectedParts);
        Navigator.of(context).pushNamedAndRemoveUntil(BarcodeScanWidget.route, (route) => false);
      } else {
        CshSnackBar.error(context: context, message: "Something Went Wrong!!");
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _showOptionNotAllowedModal(L10n l10n) {
    var provider = ELssProviderQc.of(context, listen: false);
    showCshBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      child: WillPopScope(
        onWillPop: () async => false,
        child: OptionNotAllowedModal(
          dataList: provider.elssPartList,
          onAttachS3UrlToSku: (int point, String s3Url) {
            provider.elssPartList[point].imageS3Url = s3Url;
          },
          onSubmitCallback: () {
            Logger.debug('mydebug------_PartSelectionWidgetState._showOptionNotAllowedModal',
                [provider.checkIfImageIsAttachedToAllSkus(provider.elssPartList)]);
            if (provider.checkIfImageIsAttachedToAllSkus(provider.elssPartList)) {
              Navigator.of(context).pop(true);
              _submitElssAccept();
            } else {
              CshSnackBar.error(
                  context: context, message: l10n.attachImageEverySku, snackBarPosition: SnackBarPosition.TOP);
            }
          },
        ),
      ),
    );
  }

  _submitElssAccept() {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitElssAcceptData(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(
            context: context, message: "Elss Submitted Successfully!!", duration: SnackBarDuration.SHORT);
        Navigator.pushNamedAndRemoveUntil(context, BarcodeScanWidget.route, (route) => false);
      } else {
        CshSnackBar.error(context: context, message: "Something Went Wrong");
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }
}
