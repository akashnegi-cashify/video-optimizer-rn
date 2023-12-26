import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide iterate, ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/providers/retrieved_part_list_provider.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../l10n.dart';

class RetrievedPartListWidget extends StatefulWidget {
  const RetrievedPartListWidget({super.key});

  @override
  State<RetrievedPartListWidget> createState() => _RetrievedPartListWidgetState();
}

class _RetrievedPartListWidgetState extends PaginatedListState<RetrievedPartListData, RetrievedPartListWidget> {
  final _barcodeController = TextEditingController();

  final _debounce = TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = RetrievedPartListProvider.of(context);
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
              child: CshTextFormField(
                hintText: l10n.retrievedPartBarcode,
                hintStyle: theme.textTheme.labelSmall,
                controller: _barcodeController,
                onChanged: (_) {
                  _debounce.start(() {
                    provider.searchQuery = _barcodeController.text;
                    resetAndRefreshScreen();
                  });
                },
                suffixIcon: InkWell(
                  child: const Icon(Icons.qr_code_2),
                  onTap: () {
                    CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                      Navigator.pop(context); // close scanner
                      _barcodeController.text = scannedData;
                      provider.searchQuery = _barcodeController.text;
                      resetAndRefreshScreen();
                    });
                  },
                ),
              ),
            ),
            Expanded(
                child: iterate(
              (item, index) {
                return _RetrievedPartItem(
                  item,
                  provider.roleType,
                  onCardClicked: (isFaulty) {
                    if (item.partId != null) {
                      _showUnlinkModal(context, theme, l10n, isFaulty, provider, item);
                    } else {
                      CshSnackBar.error(context: context, message: l10n.noPridFound);
                    }
                  },
                );
              },
              onRefresh: () async {},
              separator: const SizedBox(height: Dimens.space_16),
              padding: const EdgeInsets.all(Dimens.space_16),
              onNoDataFound: () {
                return Center(child: Text("No data found", style: theme.primaryTextTheme.titleMedium));
              },
            ))
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
      onDidPop: () => resetAndRefreshScreen(),
      onScanned: (scannedData, controller) {
        CshLoading().showLoading(context);
        controller?.stop();
        provider.receivePart(scannedData).then((value) {
          CshLoading().hideLoading(context);
          CshSnackBar.success(context: context, message: "Part received successfully");
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error.toString());
        }).whenComplete(() => controller?.start());
      },
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<RetrievedPartListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = RetrievedPartListProvider.of(context, listen: false);
    provider.getList(++pageNo, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
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
        MediaUploadUtil(service: ImageUploadServiceType.trc.service)
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
    provider.updateRetrievedPartStatus(isFaulty, partId, imageUrl).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
      resetAndRefreshScreen();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void dispose() {
    _debounce.stop();
    _barcodeController.dispose();
    super.dispose();
  }
}

class _RetrievedPartItem extends StatelessWidget {
  final RetrievedPartListData item;
  final RoleType roleType;
  final Function(bool isFaulty)? onCardClicked;

  const _RetrievedPartItem(this.item, this.roleType, {super.key, this.onCardClicked});

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

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.headlineMedium,
          ),
        )
      ],
    );
  }
}
