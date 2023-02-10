import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../common_models/part_device_list.dart';
import '../l10n.dart';
import '../providers/elss_provider_qc.dart';
import '../screens/add_part_screen_qc.dart';
import 'discard_modal_widget.dart';
import 'elss_device_details_widget.dart';
import 'elss_part_widget.dart';

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
    var provider = ELssProviderQc.of(context);

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
                Navigator.of(context).pushNamed(AddPartScreenQc.route, arguments: widget.barcode);
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
