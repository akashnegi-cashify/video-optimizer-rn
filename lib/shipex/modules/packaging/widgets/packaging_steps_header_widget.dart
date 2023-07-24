import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';

class PackagingHeaderWidget extends StatelessWidget {
  final String title;
  final String? lotName;
  final int? quantity;
  final String description;
  final String stepName;

  const PackagingHeaderWidget({
    super.key,
    required this.title,
    required this.description,
    required this.stepName,
    this.lotName,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        Text(
          title,
          style: theme.primaryTextTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.space_12),
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.space_8),
            border: Border.all(color: Colors.black),
            color: theme.disabledColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Validator.isNullOrEmpty(lotName)) ...[
                _horizontalKeyValuePair(theme, l10n.lotName, lotName!),
                const SizedBox(height: Dimens.space_8)
              ],
              if (quantity != null) _horizontalKeyValuePair(theme, l10n.qty, quantity!.toString()),
            ],
          ),
        ),
        const SizedBox(height: Dimens.space_12),
        Text(
          description,
          style: theme.primaryTextTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.space_12),
        Text(stepName, style: theme.primaryTextTheme.displaySmall, textAlign: TextAlign.center),
      ],
    );
  }

  _horizontalKeyValuePair(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text("$label: ", style: theme.primaryTextTheme.headlineSmall),
        const SizedBox(width: Dimens.space_8),
        Text(value, style: theme.primaryTextTheme.headlineSmall)
      ],
    );
  }
}
