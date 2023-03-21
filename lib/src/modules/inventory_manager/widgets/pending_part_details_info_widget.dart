import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/parts_details_response.dart';
import '../providers/pending_parts_details_provider.dart';

class PendingPartDetailsInfoWidget extends StatefulWidget {
  final PartDetailsData? detailsData;
  final String? suggestedBarcode;

  const PendingPartDetailsInfoWidget({
    Key? key,
    this.detailsData,
    this.suggestedBarcode,
  }) : super(key: key);

  @override
  State<PendingPartDetailsInfoWidget> createState() => _PendingPartDetailsInfoWidgetState();
}

class _PendingPartDetailsInfoWidgetState extends State<PendingPartDetailsInfoWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = PendingPartDetailsProvider.of(context);

    if (widget.detailsData != null) {
      return CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.all(Dimens.space_8),
        child: Column(
          children: [
            if (!Validator.isNullOrEmpty(widget.detailsData?.partName)) ...[
              _labelValueWidget(theme, l10n.partName, widget.detailsData!.partName!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(widget.detailsData?.sku)) ...[
              _labelValueWidget(theme, l10n.partSku, widget.detailsData!.sku!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(widget.detailsData?.partStatus)) ...[
              _labelValueWidget(theme, l10n.partStatus, widget.detailsData!.partStatus!),
              const SizedBox(height: Dimens.space_8),
            ],
            if (!Validator.isNullOrEmpty(widget.detailsData?.partColor)) ...[
              _labelValueWidget(theme, l10n.partColor, widget.detailsData!.partColor!),
              const SizedBox(height: Dimens.space_8),
            ],
            _fetchQuantityWidget(
              theme,
              l10n.availableQuantity,
              l10n.getQuantity,
              value: provider.availableQuantityResponse?.quantityData?.availableQuantity,
            ),
            const SizedBox(height: Dimens.space_8),
            if (widget.detailsData!.requestQuantity != null) ...[
              _labelValueWidget(
                theme,
                l10n.requestedQuantity,
                widget.detailsData!.requestQuantity!.toString(),
              ),
              const SizedBox(height: Dimens.space_8),
            ],
            if (widget.suggestedBarcode != null) ...[
              _labelValueWidget(
                theme,
                l10n.suggestedBarcode,
                widget.suggestedBarcode!,
                textColor: theme.errorColor,
              ),
              const SizedBox(height: Dimens.space_8),
            ],
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  _fetchAvailableQuantityOfPart() {
    var provider = PendingPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.fetchAvailableQuantity(widget.detailsData?.prid ?? -1).then((value) {
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
}
