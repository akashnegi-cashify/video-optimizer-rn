import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/dotted_divider_line.dart';

import '../../../../utils/fetch_image_widget.dart';
import '../../../engineer/models/retrieved_part_list_response.dart';
import '../../../engineer/retreived_parts/screens/image_view_screen.dart';
import '../l10n.dart';
import '../providers/action_provider.dart';

class ActionWidgetItem extends StatefulWidget {
  final RetrievedPartListData? dataModel;

  const ActionWidgetItem({
    super.key,
    this.dataModel,
  });

  @override
  State<ActionWidgetItem> createState() => _ActionWidgetItemState();
}

class _ActionWidgetItemState extends State<ActionWidgetItem> {
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    return CshCard(
      padding: EdgeInsets.zero,
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.space_12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Row(
                children: [
                  if (!Validator.isListNullOrEmpty(widget.dataModel?.imageUrls))
                    GestureDetector(
                      onTap: () {
                        ProductImageViewScreenArgument args = ProductImageViewScreenArgument(
                          listOfProductImages: widget.dataModel!.imageUrls!,
                        );
                        Navigator.of(context).pushNamed(ProductImageViewScreen.route, arguments: args);
                      },
                      child: SizedBox(
                        width: 50.0,
                        height: 80.0,
                        child: fetchImage("placeholder", widget.dataModel!.imageUrls!.first, fit: BoxFit.fill),
                      ),
                    ),
                  const SizedBox(width: Dimens.space_12),
                  Text(
                    widget.dataModel?.partName ?? "",
                    style: theme.primaryTextTheme.displaySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_12),
            DottedLineDivider(dashWidth: Dimens.space_2, width: 0.5, color: theme.shadowColor),
            const SizedBox(height: Dimens.space_12),
            if (!Validator.isNullOrEmpty(widget.dataModel?.deviceBarcode))
              _verticalKeyValuePair(theme, l10n.deviceBarcode, widget.dataModel!.deviceBarcode!),
            if (!Validator.isNullOrEmpty(widget.dataModel?.retrievedPartBarcode))
              _verticalKeyValuePair(theme, l10n.partBarcode, widget.dataModel!.retrievedPartBarcode!),
            if (!Validator.isNullOrEmpty(widget.dataModel?.remark))
              _verticalKeyValuePair(theme, l10n.remarks, widget.dataModel!.remark!),
            if (!Validator.isNullOrEmpty(widget.dataModel?.reason))
              _verticalKeyValuePair(theme, l10n.reason, widget.dataModel!.reason!),
            const SizedBox(height: Dimens.space_12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: CshTextFormField(
                controller: _remarkController,
                hintText: l10n.enterRemarksIfAny,
                maxLines: 5,
                minLines: 1,
                maxLength: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.space_12),
              child: Row(
                children: [
                  Expanded(
                    child: CshMediumOutlineButton(
                      text: l10n.faulty,
                      onPressed: () {
                        if (widget.dataModel?.partId != null) {
                          _showUnlinkModal(context, theme, l10n, true, widget.dataModel);
                        } else {
                          CshSnackBar.error(context: context, message: l10n.noProductIdFound);
                        }
                      },
                      borderColor: theme.colorScheme.error,
                      textColor: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(width: Dimens.space_8),
                  Expanded(
                    child: CshMediumOutlineButton(
                      text: l10n.working,
                      onPressed: () {
                        if (widget.dataModel?.partId != null) {
                          _showUnlinkModal(context, theme, l10n, false, widget.dataModel);
                        } else {
                          CshSnackBar.error(context: context, message: l10n.noProductIdFound);
                        }
                      },
                      borderColor: customTheme.successColor,
                      textColor: customTheme.successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verticalKeyValuePair(ThemeData theme, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Text(
              "$key :",
              style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.shadowColor),
            ),
          ),
          const SizedBox(height: Dimens.space_4),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Text(
              value,
              style: theme.primaryTextTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }

  _showUnlinkModal(
    BuildContext context,
    ThemeData theme,
    L10n l10n,
    bool isFaulty,
    RetrievedPartListData? item,
  ) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty
                  ? l10n.areYouSureYouWantToMarkPartAsFaulty(item?.retrievedPartBarcode ?? "part")
                  : l10n.areYouSureYouWantToMarkPartAsOk(item?.retrievedPartBarcode ?? "part"),
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
                _updatePartStatus(context, isFaulty, l10n, item?.partId ?? -1);
              },
            )
          ],
        ),
      ),
    );
  }

  _updatePartStatus(
    BuildContext context,
    bool isFaulty,
    L10n l10n,
    int partId,
  ) {
    CshLoading().showLoading(context);
    var provider = ActionProvider.of(context, listen: false);
    provider.updateRetrievedPartStatus(isFaulty, partId, _remarkController.text).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
      _remarkController.clear();
      Navigator.of(context).pop();
      setState(() {});
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
