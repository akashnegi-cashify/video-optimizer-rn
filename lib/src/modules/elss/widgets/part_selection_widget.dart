import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/providers/elss_provider.dart';

import '../l10n.dart';
import '../models/part_device_list.dart';
import '../screens/add_part_screen.dart';
import '../screens/elss_screen.dart';
import 'discard_modal_widget.dart';
import 'elss_device_details_widget.dart';
import 'elss_part_widget.dart';
import 'option_widget.dart';

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
  bool _isSearching = false;

  List<PartItemDataResponse> additionalRequiredPartList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ELssProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.space_8),
          child: ElssDeviceDetailsWidget(dataModel: provider.elssDeviceDetails?.deviceDetailsData),
        ),
        const SizedBox(height: Dimens.space_20),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
            child: CshIconButton(
              text: l10n.addParts,
              onPressed: () {
                Navigator.of(context).pushNamed(AddPartScreen.route, arguments: widget.barcode);
              },
              prefixIcon: CshIcon(
                FeatherIcons.plus,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        if (!Validator.isListNullOrEmpty(provider.elssPartList)) ...[
          if (_isSearching)
            Expanded(
              child: (provider.searchedElssPartList.isNotEmpty)
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ElssPartWidget(
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
                  return ElssPartWidget(
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
        return const DiscardModalWidget();
      },
    );
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
                borderColor: theme.primaryColor,
                onPressed: () {
                  if (onPNA != null) {
                    onPNA();
                  }
                },
              ),
            ),
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
}
// (provider.isElssOptionsLoading)
//     ? SizedBox(
//         height: Dimens.space_50,
//         width: MediaQuery.of(context).size.width,
//         child: const Center(
//           child: SizedBox(
//             height: Dimens.space_20,
//             width: Dimens.space_20,
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       )
//     : (provider.elssOptionResponse != null)
//         ? GestureDetector(
//             onVerticalDragStart: (data) {
//               if (data.globalPosition.dx > 40.0) {
//                 _showElssOptionsModal(l10n, theme);
//               }
//             },
//             child: Container(
//               height: Dimens.space_50,
//               width: MediaQuery.of(context).size.width,
//               alignment: Alignment.center,
//               color: theme.primaryColor,
//               child: Text(
//                 l10n.swipeUpToOpen,
//                 style: theme.primaryTextTheme.headline3?.copyWith(color: theme.backgroundColor),
//               ),
//             ),
//           )
//         : const SizedBox()

// _showElssOptionsModal(L10n l10n, ThemeData theme) {
//   var provider = ELssProvider.of(context, listen: false);
//
//   showCshBottomSheet(
//     context: context,
//     child: AnimatedContainer(
//       duration: const Duration(milliseconds: 700),
//       child: StatefulBuilder(
//         builder: (BuildContext insideContext, StateSetter setState) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: Dimens.space_50,
//                   width: MediaQuery.of(context).size.width,
//                   alignment: Alignment.center,
//                   color: theme.primaryColor,
//                   child: Text(
//                     l10n.swipeDownToClose,
//                     style: theme.primaryTextTheme.headline3?.copyWith(color: theme.backgroundColor),
//                   ),
//                 ),
//                 if (!Validator.isListNullOrEmpty(provider.productOptionList))
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return PartSelectionOptionWidget(
//                         keyValue: provider.productOptionList[index].key ?? 0,
//                         onGroupValueChanged: (int data) {
//                           provider.setSelectedOptionKey(data);
//                           setState(() {});
//                         },
//                         onApplicableReasonCallback: (int keyValue, bool isGcs, bool isPna, bool isRub) {
//                           provider.setApplicableReasonsToOptions(keyValue,
//                               isGca: isGcs, isPnaa: isPna, isRuba: isRub);
//                           setState(() {});
//                         },
//                         groupValueKey: provider.selectedOptionKey,
//                         dataModel: provider.productOptionList[index],
//                       );
//                     },
//                     itemCount: provider.productOptionList.length,
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: CshMediumButton(
//                       text: provider.submitButtonName,
//                       onPressed: () {
//                         Navigator.of(context).pop(true);
//                         Map<String, List<String>> imagesDataMap = provider.getSelectedPartsFaultImages();
//                         if (imagesDataMap.isNotEmpty) {
//                           provider.submitPartsFaultImages(widget.barcode, imagesDataMap);
//                         }
//                         _submitElssPartRequest(widget.barcode, l10n);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     ),
//   ).then(
//         (value) {
//       if (provider.selectedOptionKey != -1) {
//         provider.resetSelectedOptions();
//       }
//     },
//   );
// }
// _submitElssPartRequest(String barcode, L10n l10n) {
//   var provider = ELssProvider.of(context, listen: false);
//   CshLoading().showLoading(context);
//   provider.submitElssPartRequest(barcode).then((value) {
//     if (value) {
//       CshLoading().hideLoading(context);
//       CshSnackBar.success(
//           context: context,
//           message: provider.elssPartSubmitResponse?.successMessage ?? l10n.dataSubmittedSuccessfully);
//       Navigator.pushNamedAndRemoveUntil(context, ELSSScreen.route, (route) => false);
//     } else {
//       CshLoading().hideLoading(context);
//       CshSnackBar.error(
//           context: context, message: provider.elssPartSubmitResponse?.errorMessage ?? l10n.errorInSubmittingDetails);
//     }
//   }, onError: (error) {
//     CshLoading().hideLoading(context);
//     CshSnackBar.error(context: context, message: error);
//   });
// }
