import 'dart:async';
import 'dart:io';

import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate, ImageUtil;
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/gallery_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/providers/retrieved_part_list_provider.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/models/media_upload_service_type_enum.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../utils/fetch_image_widget.dart';
import '../l10n.dart';

class RetrievedPartListWidget extends StatefulWidget {
  const RetrievedPartListWidget({super.key});

  @override
  State<RetrievedPartListWidget> createState() => _RetrievedPartListWidgetState();
}

class _RetrievedPartListWidgetState extends State<RetrievedPartListWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search Retrieved Part Barcode",
        field: 'retrievedPartBarcode',
        crudFilter: 'retrievedPartBarcode',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Part Name",
        field: 'partName',
        crudFilter: 'partName',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "SKU",
        field: 'sku',
        crudFilter: 'partSku',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Part Variation",
        field: 'partVariationName',
        crudFilter: 'request.partVariantName',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Device Barcode",
        field: 'deviceBarcode',
        crudFilter: 'device.barcode',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Part ID",
        field: 'partId',
        crudFilter: 'partId',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.number,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = RetrievedPartListProvider.of(context, listen: false);
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: CshApiList<RetrievedPartListData>(
                apiConfig: ListApiConfig(
                  apiUrl: "/engineer/list/retrieved-part",
                  serviceGroup: TRCServiceGroups.unifyTrc,
                ),
                filterConfig: _getFilterConfig(),
                controller: _listController,
                itemFromJson: RetrievedPartListData.fromJson,
                shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                listPadding: const EdgeInsets.all(Dimens.space_16),
                verticalRowSpacing: Dimens.space_16,
                isHideCoreFilterButton: false,
                getRowWidget: (item, index) {
                  final data = item;
                    return _RetrievedPartItem(
                    data!,
                      provider.roleType,
                      onCardClicked: (isFaulty) {
                      if (data.partId != null) {
                        _showUnlinkModal(context, theme, l10n, isFaulty, provider, data);
                        } else {
                          CshSnackBar.error(context: context, message: l10n.noPridFound);
                        }
                      },
                    );
                  },
              ),
            ),
          ],
        ),
        if (provider.roleType == RoleType.partQc)
          Positioned(
              bottom: Dimens.space_16,
              right: Dimens.space_16,
              child: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                onPressed: () => _onAddIconClicked(provider),
                child: CshIcon(
                  FeatherIcons.plus,
                  iconColor: theme.colorScheme.onPrimary,
                  iconSize: MobileIconSize.medium,
                ),
              ))
      ],
    );
  }

  _onAddIconClicked(RetrievedPartListProvider provider) {
    CshMlScannerUtil().openScanner(
      context,
      header: "Receive Retrieved Parts",
      hintText: "Scan Retrieved Part Barcode",
      onDidPop: () => _refreshList(),
      onScanned: (scannedData, controller) {
        CshLoading().showLoading(context);
        controller?.stop();
        provider.receivePart(scannedData).then((value) {
          CshLoading().hideLoading(context);
          CshSnackBar.success(context: context, message: "Part received successfully");
          _refreshList();
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error.toString());
        }).whenComplete(() => controller?.start());
      },
    );
  }

  _showUnlinkModal(
    BuildContext context,
    ThemeData theme,
    L10n l10n,
    bool isFaulty,
    RetrievedPartListProvider provider,
    RetrievedPartListData item,
  ) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty
                  ? l10n.areYouSureYouWantToMarkPartAsFaulty(item.retrievedPartBarcode ?? "part")
                  : l10n.areYouSureYouWantToMarkPartAsOk(item.retrievedPartBarcode ?? "part"),
              style: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () async {
                Navigator.of(context).pop();
                _getFileUrl().then((imageUrl) {
                  _updatePartStatus(context, isFaulty, l10n, provider, item.partId!, imageUrl);
                }, onError: (error) {
                  CshSnackBar.error(context: context, message: error.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<String> _getFileUrl() async {
    var completer = Completer<String>();
    var xFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (xFile != null && mounted) {
      CshLoading().showLoading(context);
      ImageUtil.compressImage(File(xFile.path)).then((compressedFile) {
        String fileName = path.basename(compressedFile.path);
        MediaUploadUtil(service: MediaUploadServiceType.trc.service)
            .uploadMediaWithType(mediaFile: compressedFile, fileName: fileName)
            .then((value) {
          CshLoading().hideLoading(context);
          completer.complete(value);
        }, onError: (error) {
          CshLoading().hideLoading(context);
          completer.completeError(error);
        });
      });
    }
    return completer.future;
  }

  _updatePartStatus(
    BuildContext context,
    bool isFaulty,
    L10n l10n,
    RetrievedPartListProvider provider,
    int partId,
    String imageUrl,
  ) {
    CshLoading().showLoading(context);
    provider.updateRetrievedPartStatus(isFaulty, partId).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
      _refreshList();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _RetrievedPartItem extends StatelessWidget {
  final RetrievedPartListData item;
  final RoleType roleType;
  final Function(bool isFaulty)? onCardClicked;

  const _RetrievedPartItem(this.item, this.roleType, {this.onCardClicked});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var l10n = L10n(context);
    return CshCard(
      child: Column(
        children: [
          _labelValueWidget(theme, l10n.sku, item.sku ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.partName, item.partName ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.deviceBarcode, item.deviceBarcode ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.retrievedPartsBarcode, item.retrievedPartBarcode ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(
            theme,
            l10n.additionalInfo,
            "View",
            isMetaData: true,
            onClick: () {
              _showMetaDataDialog(context, item.partName ?? "", item.imageUrls, item.reason, item.remark);
            },
          ),
          if (roleType == RoleType.partQc) ...[
            // const SizedBox(height: Dimens.space_8),
            const Divider(),
            Row(
              children: [
                _bottomButton(theme, customTheme, true),
                const SizedBox(width: Dimens.space_16),
                _bottomButton(theme, customTheme, false),
              ],
            )
          ]
        ],
      ),
    );
  }

  _showMetaDataDialog(
    BuildContext context,
    String partName,
    List<String>? imageUrls,
    String? reasons,
    String? remarks,
  ) {
    showCshBottomSheet(
        context: context,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.space_8),
              CshTextNew.subTitle1(partName),
              const SizedBox(height: Dimens.space_8),
              const Divider(),
              const SizedBox(height: Dimens.space_16),
              if (!Validator.isNullOrEmpty(reasons))
                Row(
                  children: [
                    Expanded(child: CshTextNew.bodyText1("Reason")),
                    Expanded(child: CshTextNew.subTitle1(reasons.toString())),
                  ],
                ),
              if (!Validator.isNullOrEmpty(remarks))
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.space_16),
                  child: Row(
                    children: [
                      Expanded(child: CshTextNew.bodyText1("Remarks")),
                      Expanded(child: CshTextNew.subTitle1(remarks.toString())),
                    ],
                  ),
                ),
              const SizedBox(height: Dimens.space_16),
              SizedBox(
                height: Dimens.space_120,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    String url = imageUrls![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, GalleryScreen.route,
                            arguments: GalleryScreenArguments(getGalleryImages(imageUrls)));
                      },
                      child: CshCard(
                          padding: const EdgeInsets.all(Dimens.space_4),
                          child: fetchImage(ImageAssetHelper.imagePath("placeholder.png"), url)),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: Dimens.space_16);
                  },
                  itemCount: imageUrls?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _bottomButton(ThemeData theme, CustomColors customTheme, bool isFaulty) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onCardClicked?.call(isFaulty),
        child: Row(
          children: [
            CshIcon(
              isFaulty ? FeatherIcons.x : FeatherIcons.check,
              iconColor: isFaulty ? theme.colorScheme.error : customTheme.successColor,
              padding: const EdgeInsets.only(right: Dimens.space_4),
            ),
            Text(
              isFaulty ? "Faulty" : "Working",
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value, {bool isMetaData = false, VoidCallback? onClick}) {
    TextStyle? textStyle = isMetaData
        ? theme.primaryTextTheme.headlineMedium?.copyWith(
            color: theme.primaryColor,
            decoration: TextDecoration.underline,
          )
        : theme.primaryTextTheme.headlineMedium;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: isMetaData
                ? () {
                    onClick?.call();
                  }
                : null,
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
          ),
        )
      ],
    );
  }

  List<List<ImageData>>? getGalleryImages(List<String>? imageUrls) {
    if (Validator.isListNullOrEmpty(imageUrls)) {
      return null;
    }
    List<List<ImageData>>? list = [];
    for (var i = 0; i < imageUrls!.length; i++) {
      var item = imageUrls[i];
      // if (item.path != null) {
      list.add([ImageData(i, item)]);
      // }
    }
    return list;
  }
}
