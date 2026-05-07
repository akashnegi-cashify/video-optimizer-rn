import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../resources/body_shop_device_response.dart';

class BodyShopDeviceWidget extends StatelessWidget {
  final BodyShopDevice? item;
  final int index;
  final VoidCallback? onItemClick;

  const BodyShopDeviceWidget({super.key, required this.index, this.item, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return cshGestureDetector(
      onTap: onItemClick,
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew(
              '#${index + 1}   ${item?.deviceBarcode ?? ''}',
              textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: Dimens.space_12),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Model", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.model ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Status", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.statusDescription ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Engineer", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.engineer ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
          ],
        ),
      ),
    );
  }
}
