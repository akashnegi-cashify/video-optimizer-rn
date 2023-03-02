import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../amplify/amplifier.dart';
import '../../../../amplify/amplify_provider.dart';
import '../../common_models/elss_part.dart';
import '../l10n.dart';
import 'option_sku_tile_widget.dart';

class OptionNotAllowedModal extends StatefulWidget {
  final List<ElssPart>? dataList;
  final Function() onSubmitCallback;
  final Function() onResetButtonCallback;

  const OptionNotAllowedModal({
    Key? key,
    this.dataList,
    required this.onResetButtonCallback,
    required this.onSubmitCallback,
  }) : super(key: key);

  @override
  State<OptionNotAllowedModal> createState() => _OptionNotAllowedModalState();
}

class _OptionNotAllowedModalState extends State<OptionNotAllowedModal> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.listOfSkUs,
            style: theme.primaryTextTheme.headline2,
          ),
          (!Validator.isListNullOrEmpty(widget.dataList))
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
                    itemBuilder: (context, index) {
                      return OptionSkuTileWidget(
                        (index + 1),
                        dataModel: widget.dataList![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: widget.dataList!.length,
                  ),
                )
              : const SizedBox.shrink(),
          ComboButton(
            firstBtnText: l10n.reset,
            secondBtnText: l10n.submit,
            isFirstPrimary: true,
            buttonType: ButtonType.mini,
            firstBtnClick: widget.onResetButtonCallback,
            secondBtnClick: widget.onSubmitCallback,
          ),
        ],
      ),
    );
  }
}
