import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';
import '../providers/elss_provider_trc.dart';
import '../screens/add_part_screen_trc.dart';
import 'elss_device_details_widget_trc.dart';
import 'elss_part_widget_trc.dart';
import 'option_widget_trc.dart';

class PartSelectionWidgetTrc extends StatefulWidget {
  final String barcode;

  const PartSelectionWidgetTrc({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  State<PartSelectionWidgetTrc> createState() => _PartSelectionWidgetTrcState();
}

class _PartSelectionWidgetTrcState extends State<PartSelectionWidgetTrc> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  List<PartItemDataResponse> additionalRequiredPartList = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ELssProviderTrc.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.space_8),
          child: ElssDeviceDetailsWidgetTrc(dataModel: provider.elssDeviceDetails?.deviceDetailsData),
        ),
        if (!Validator.isListNullOrEmpty(provider.elssPartList)) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
            child: CshTextFormField(
              controller: _searchController,
              counterText: "",
              autofocus: false,
              maxLines: 1,
              maxLength: 50,
              hintText: l10n.searchPart,
              onChanged: (data) {
                if (_timer?.isActive ?? false) _timer?.cancel();
                _timer = Timer(
                  const Duration(milliseconds: 500),
                  () {
                    if (data.isNotEmpty) {
                      var dt = data.trim();
                      provider.getSearchResults(dt);
                      _isSearching = true;
                    } else {
                      _isSearching = false;
                      provider.clearSearchResults();
                    }
                  },
                );
              },
            ),
          ),
          if (_isSearching)
            Expanded(
              child: (provider.searchedElssPartList.isNotEmpty)
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ElssPartWidgetTrc(
                          key: const Key("Searching_List"),
                          onImageUploadCallback: (int imageIndex, String s3Url) {
                            provider.addS3UrlToListOfPartsImage(
                                provider.searchedElssPartList[index].elssPartId!, index, s3Url);
                          },
                          indexData: index + 1,
                          onPartRemoved: (int id) {
                            provider.removeAddedDataFromSearchAndMasterList(id);
                          },
                          dataModel: provider.searchedElssPartList[index],
                          onActionChanged: (String data) {
                            provider.searchItemDataUpdate(provider.searchedElssPartList[index].elssPartId!,
                                action: data);
                          },
                        );
                      },
                      itemCount: provider.searchedElssPartList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                    )
                  : Center(
                      child: Text(l10n.noPartFound, style: theme.primaryTextTheme.headline3),
                    ),
            ),
          if (!_isSearching)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ElssPartWidgetTrc(
                    key: const Key("Master_List"),
                    onImageUploadCallback: (int imageIndex, String s3Url) {
                      provider.addS3UrlToListOfPartsImage(provider.elssPartList[index].elssPartId!, imageIndex, s3Url);
                    },
                    indexData: provider.elssPartList[index].elssPartId ?? -1,
                    onPartRemoved: (int id) {
                      provider.removeExternalAddedPart(id);
                    },
                    dataModel: provider.elssPartList[index],
                    onActionChanged: (String data) {
                      provider.searchItemDataUpdate(provider.elssPartList[index].elssPartId!, action: data);
                    },
                  );
                },
                itemCount: provider.elssPartList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.space_8);
                },
              ),
            ),
        ] else
          const Expanded(
            child: SizedBox(),
          ),
        GestureDetector(
          onTap: () async {
            var data = await Navigator.of(context).pushNamed(AddPartScreenTrc.route, arguments: widget.barcode);
            if ((data is List<PartItemDataResponse>?) && !Validator.isListNullOrEmpty(data)) {
              for (var element in data!) {
                Logger.debug('mydebug------_PartSelectionWidgetState.build', [element.toJson()]);
              }
              provider.addNewPartsFromAddParts(data);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CshIcon(
                FeatherIcons.plus,
                iconSize: MobileIconSize.large,
              ),
              Text(
                l10n.addPart,
                style: theme.primaryTextTheme.headline2,
              )
            ],
          ),
        ),
        (provider.isElssOptionsLoading)
            ? SizedBox(
                height: Dimens.space_50,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: SizedBox(
                    height: Dimens.space_20,
                    width: Dimens.space_20,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : (provider.elssOptionResponse != null)
                ? GestureDetector(
                    onVerticalDragStart: (data) {
                      if (data.globalPosition.dx > 40.0) {
                        _showElssOptionsModal(l10n, theme);
                      }
                    },
                    child: Container(
                      height: Dimens.space_50,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      color: theme.primaryColor,
                      child: Text(
                        l10n.swipeUpToOpen,
                        style: theme.primaryTextTheme.headline3?.copyWith(color: theme.backgroundColor),
                      ),
                    ),
                  )
                : const SizedBox()
      ],
    );
  }

  _showElssOptionsModal(L10n l10n, ThemeData theme) {
    var provider = ELssProviderTrc.of(context, listen: false);

    showCshBottomSheet(
      context: context,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: StatefulBuilder(
          builder: (BuildContext insideContext, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimens.space_50,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    color: theme.primaryColor,
                    child: Text(
                      l10n.swipeDownToClose,
                      style: theme.primaryTextTheme.headline3?.copyWith(color: theme.backgroundColor),
                    ),
                  ),
                  if (!Validator.isListNullOrEmpty(provider.productOptionList))
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PartSelectionOptionWidget(
                          keyValue: provider.productOptionList[index].key ?? 0,
                          onGroupValueChanged: (int data) {
                            provider.setSelectedOptionKey(data);
                            setState(() {});
                          },
                          onApplicableReasonCallback: (int keyValue, bool isGcs, bool isPna, bool isRub) {
                            provider.setApplicableReasonsToOptions(keyValue,
                                isGca: isGcs, isPnaa: isPna, isRuba: isRub);
                            setState(() {});
                          },
                          groupValueKey: provider.selectedOptionKey,
                          dataModel: provider.productOptionList[index],
                        );
                      },
                      itemCount: provider.productOptionList.length,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
                    child: SizedBox(
                      width: double.infinity,
                      child: CshMediumButton(
                        text: provider.submitButtonName,
                        onPressed: () {
                          if (provider.getIsPnaSelectedOrNot(provider.selectedOptionKey)) {
                            _showDialogueWhenPnaSelected(l10n, theme, provider.selectedOptionKey, provider);
                          } else {
                            Navigator.of(context).pop(true);
                            Map<String, List<String>> imagesDataMap = provider.getSelectedPartsFaultImages();
                            if (imagesDataMap.isNotEmpty) {
                              provider.submitPartsFaultImages(widget.barcode, imagesDataMap);
                            }
                            _submitElssPartRequest(widget.barcode, l10n);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ).then(
      (value) {
        if (provider.selectedOptionKey != -1) {
          provider.resetSelectedOptions();
        }
      },
    );
  }

  _submitElssPartRequest(String barcode, L10n l10n) {
    var provider = ELssProviderTrc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitElssPartRequest(barcode).then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(
            context: context,
            message: provider.elssPartSubmitResponse?.successMessage ?? l10n.dataSubmittedSuccessfully);
        Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false);
      } else {
        CshLoading().hideLoading(context);
        CshSnackBar.error(
            context: context, message: provider.elssPartSubmitResponse?.errorMessage ?? l10n.errorInSubmittingDetails);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _showDialogueWhenPnaSelected(L10n l10n, ThemeData theme, int selectedKey, ELssProviderTrc provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.space_8),
          topLeft: Radius.circular(Dimens.space_8),
        ),
      ),
      builder: (BuildContext innerContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                child: Text(
                  (Validator.isListNullOrEmpty(provider.manualAddedPartsList))
                      ? l10n.noPartAddedForPna
                      : l10n.selectedPartsForPna,
                  style: theme.primaryTextTheme.headline3,
                ),
              ),
              const SizedBox(height: Dimens.space_8),
              SizedBox(
                width: double.infinity,
                height: 400.0,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                    itemBuilder: (context, index) {
                      return AddPartItemList(
                        dataModel: PartItemDataResponse(
                          provider.manualAddedPartsList[index].sku,
                          provider.manualAddedPartsList[index].partColour,
                          provider.manualAddedPartsList[index].partName,
                          isCardSelected: false,
                        ),
                        onPartSelected: (bool data) {
                          provider.manualAddedPartsList[index].isPnaSelected = data;
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: provider.manualAddedPartsList.length),
              ),
              const SizedBox(height: Dimens.space_8),
              ComboButton(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                firstBtnText: l10n.cancel,
                secondBtnText:
                    (Validator.isListNullOrEmpty(provider.manualAddedPartsList)) ? l10n.selectParts : l10n.submit,
                isFirstPrimary: true,
                buttonType: ButtonType.mini,
                firstBtnClick: () {
                  Navigator.of(context).pop(true);
                },
                secondBtnClick: (Validator.isListNullOrEmpty(provider.manualAddedPartsList))
                    ? () async {
                        Navigator.of(context).pop(true);
                        var data =
                            await Navigator.of(context).pushNamed(AddPartScreenTrc.route, arguments: widget.barcode);
                        if ((data is List<PartItemDataResponse>?) && !Validator.isListNullOrEmpty(data)) {
                          for (var element in data!) {
                            Logger.debug('mydebug------_PartSelectionWidgetState.build', [element.toJson()]);
                          }
                          provider.addNewPartsFromAddParts(data);
                        }
                      }
                    : () {
                        Navigator.of(context).pop(true);
                        _submitPopUpAfterPNA(l10n, theme, selectedKey, provider);
                      },
              )
            ],
          ),
        );
      },
    );
  }

  _submitPopUpAfterPNA(L10n l10n, ThemeData theme, int selectedKey, ELssProviderTrc provider) {
    showDialog(
      context: context,
      builder: (BuildContext innerContext) {
        return AlertDialog(
          title: Text(
            l10n.submitParts,
            style: theme.primaryTextTheme.headline3,
          ),
          content: Text(
            l10n.areYouSureYouWantToSubmit,
            style: theme.primaryTextTheme.headline4,
          ),
          actions: [
            CshMediumButton(
              text: l10n.cancel,
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
            CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Map<String, List<String>> imagesDataMap = provider.getSelectedPartsFaultImages();
                if (imagesDataMap.isNotEmpty) {
                  provider.submitPartsFaultImages(widget.barcode, imagesDataMap);
                }
                _submitElssPartRequest(widget.barcode, l10n);
              },
            )
          ],
        );
      },
    );
  }
}
