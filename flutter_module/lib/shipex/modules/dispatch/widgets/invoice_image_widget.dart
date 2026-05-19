import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class InvoiceImageWidget extends StatelessWidget {
  final File imageFile;
  final Function(File)? onCrossedCallback;

  const InvoiceImageWidget({
    super.key,
    required this.imageFile,
    this.onCrossedCallback,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.space_6),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.space_6), child: Image.file(imageFile, fit: BoxFit.cover)),
        ),
        Positioned(
          top: -6.0,
          right: -6.0,
          child: GestureDetector(
            onTap: () {
              if (onCrossedCallback != null) {
                onCrossedCallback!(imageFile);
              }
            },
            child: Container(
              height: Dimens.space_20,
              width: Dimens.space_20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.cardColor,
              ),
              child: CshIcon(
                FeatherIcons.x,
                padding: EdgeInsets.zero,
                iconSize: MobileIconSize.small,
                iconColor: theme.colorScheme.error,
              ),
            ),
          ),
        )
      ],
    );
  }
}
