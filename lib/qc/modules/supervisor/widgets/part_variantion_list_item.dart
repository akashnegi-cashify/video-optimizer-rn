import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n.dart';

enum CountingType { alphabet, numeric }

class PartVariationListItem extends StatefulWidget {
  final PartVariationData item;
  final int index;
  final Function(String variantId)? onValueSelected;
  final CountingType countingType;
  final Function(String imageUrl)? onImageClicked;
  final VoidCallback? onReset;

  const PartVariationListItem(
    this.item,
    this.index, {
    super.key,
    this.onValueSelected,
    this.onImageClicked,
    this.onReset,
    this.countingType = CountingType.alphabet,
  });

  @override
  State<PartVariationListItem> createState() => _PartVariationListItemState();
}

class _PartVariationListItemState extends State<PartVariationListItem> {
  DropDownItem? _selectedItem;
  final List<DropDownItem> _items = [];
  int _resetCounter = 0;
  late String countingString;

  @override
  void initState() {
    if (widget.countingType == CountingType.alphabet) {
      countingString = String.fromCharCode(97 + widget.index);
    } else {
      countingString = (widget.index + 1).toString();
    }

    widget.item.value?.forEach((key, value) {
      _items.add(DropDownItem(key, value));
    });

    var index = _items.indexWhere((element) => element.id == widget.item.userSelectedVariantId);
    if (index != -1) {
      _selectedItem = _items[index];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var l10n = L10n(context);
    return CshCard(
      elevation: CardElevation.none,
      padding: const EdgeInsets.all(Dimens.space_12),
      bgColor: const Color(0xfff8f8f8f).withAlpha(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "$countingString. ${widget.item.partName}",
                  style: theme.textTheme.titleSmall,
                  maxLines: 2,
                ),
              ),
              Validator.isNullOrEmpty(widget.item.imageUrl)
                  ? CshIcon(
                      FeatherIcons.camera,
                      padding: EdgeInsets.zero,
                      iconColor: _selectedItem != null ? Colors.black : theme.disabledColor,
                      onClick: _selectedItem != null ? () => _onImageClicked() : null,
                    )
                  : InkWell(
                      onTap: () => _onImageClicked(),
                      child: Text(
                        l10n.added,
                        style: theme.textTheme.titleSmall?.copyWith(color: theme.primaryColor),
                      ),
                    ),
              const SizedBox(width: Dimens.space_16),
              CshIcon(
                FeatherIcons.refreshCcw,
                padding: EdgeInsets.zero,
                iconColor: _selectedItem != null ? Colors.black : theme.disabledColor,
                onClick: _selectedItem != null ? () => _onResetButtonClicked() : null,
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: Dimens.space_12),
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: customTheme.inputStrokeColor),
                borderRadius: BorderRadius.circular(Dimens.space_4),
              ),
              child: Text(
                widget.item.selectedVariationName ?? "",
                style: theme.primaryTextTheme.bodyMedium?.copyWith(color: customTheme.inputStrokeColor),
              )),
          const SizedBox(height: Dimens.space_8),
          Container(
            color: Colors.white,
            child: CshDropDown(
                key: ValueKey(_resetCounter.toString()),
                items: _items,
                hintText: l10n.select,
                contentPadding:
                    const EdgeInsets.fromLTRB(Dimens.space_12, Dimens.space_8, Dimens.space_12, Dimens.space_8),
                hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(color: theme.primaryColor),
                selectedItem: _selectedItem,
                onChanged: (item) {
                  setState(() {
                    _selectedItem = item;
                    widget.onValueSelected?.call(item.id);
                  });
                }),
          ),
        ],
      ),
    );
  }

  _onResetButtonClicked() {
    setState(() {
      _selectedItem = null;
      _resetCounter++;
      widget.onReset?.call();
    });
  }

  _onImageClicked() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera, requestFullMetadata: false).then((value) async {
      if (value != null) {
        CshLoading().showLoading(context);
        File compressedFile = await ImageUtil.compressImage(File(value.path));
        String fileName = value.path.split("/").last;
        MediaUploadUtil().uploadMediaWithType(mediaFile: compressedFile, fileName: fileName).then((value) {
          CshLoading().hideLoading(context);
          widget.onImageClicked?.call(value);
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
        });
      }
    });
  }
}
