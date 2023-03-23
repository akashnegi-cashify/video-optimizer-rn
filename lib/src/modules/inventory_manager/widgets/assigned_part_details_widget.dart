import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../l10n.dart';
import '../models/assigned_part_details_response.dart';
import '../providers/assinged_part_details_provider.dart';

class AssignedPartDetailsWidget extends StatefulWidget {
  final AssignedPartsDetails? detailsData;
  final int prid;

  const AssignedPartDetailsWidget({
    Key? key,
    required this.prid,
    this.detailsData,
  }) : super(key: key);

  @override
  State<AssignedPartDetailsWidget> createState() => _AssignedPartDetailsWidgetState();
}

class _AssignedPartDetailsWidgetState extends State<AssignedPartDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = AssignedPartDetailsProvider.of(context);

    return Column(
      children: [
        CshCard(
          radius: CshRadius.rad8,
          elevation: CardElevation.dimen_10,
          padding: const EdgeInsets.all(Dimens.space_8),
          child: Column(
            children: [
              if (!Validator.isNullOrEmpty(widget.detailsData?.data?.productName)) ...[
                _labelValueWidget(theme, l10n.partName, widget.detailsData!.data!.productName!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(widget.detailsData?.data?.sku)) ...[
                _labelValueWidget(theme, l10n.partSku, widget.detailsData!.data!.sku!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(widget.detailsData?.data?.status)) ...[
                _labelValueWidget(theme, l10n.partStatus, widget.detailsData!.data!.status!),
                const SizedBox(height: Dimens.space_8),
              ],
              if (!Validator.isNullOrEmpty(widget.detailsData?.data?.productColour)) ...[
                _labelValueWidget(theme, l10n.partColor, widget.detailsData!.data!.productColour!),
                const SizedBox(height: Dimens.space_8),
              ],
              _fetchQuantityWidget(
                theme,
                l10n.availableQuantity,
                l10n.getQuantity,
                value: provider.partAvailableQuantityResponse?.quantityData?.availableQuantity,
              ),
              const SizedBox(height: Dimens.space_8),
              if (widget.detailsData?.data?.requiredQuantity != null) ...[
                _labelValueWidget(
                  theme,
                  l10n.requestedQuantity,
                  widget.detailsData!.data!.requiredQuantity!.toString(),
                ),
                const SizedBox(height: Dimens.space_8),
              ],
            ],
          ),
        ),
        const SizedBox(height: Dimens.space_20),
        if (!Validator.isNullOrEmpty(widget.detailsData?.data?.productBarcode))
          CshCard(
            radius: CshRadius.rad8,
            elevation: CardElevation.dimen_10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.partBarcode,
                  style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
                ),
                Row(
                  children: [
                    Text(
                      widget.detailsData!.data!.productBarcode!,
                      style: theme.primaryTextTheme.headline4,
                    ),
                    const SizedBox(width: Dimens.space_4),
                    CshIcon(
                      FeatherIcons.link2,
                      iconSize: MobileIconSize.medium,
                      padding: EdgeInsets.zero,
                      iconColor: theme.errorColor,
                      onClick: () {
                        _showUnlinkModal(context, theme, l10n, widget.prid);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  _fetchAvailableQuantityOfPart() {
    var provider = AssignedPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getAssignedPartQuantity().then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _fetchQuantityWidget(ThemeData theme, String label, String buttonLabel, {int? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
        ),
        (value == null)
            ? CshMediumButton(
                text: buttonLabel,
                onPressed: () {
                  _fetchAvailableQuantityOfPart();
                },
              )
            : Text(
                value.toString(),
                style: theme.primaryTextTheme.headline5,
              )
      ],
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value, {Color? textColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            style: textColor != null
                ? theme.primaryTextTheme.headline5?.copyWith(color: textColor)
                : theme.primaryTextTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  _showUnlinkModal(BuildContext context, ThemeData theme, L10n l10n, int prid) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              l10n.areYouSureYouWantToUnlinkThePart,
              style: theme.primaryTextTheme.headline3,
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
              secondBtnClick: () {
                Navigator.of(context).pop();
                _unlinkPart(l10n);
              },
            )
          ],
        ),
      ),
    );
  }

  _unlinkPart(L10n l10n) {
    var provider = AssignedPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.unlinkPartBarcode().then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.partUnlinkedSuccessfully);
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
