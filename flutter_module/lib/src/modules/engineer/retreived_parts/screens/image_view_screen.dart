
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_gallery_view/csh_gallery_view.dart';
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ProductImageViewScreenArgument {
  final List<String> listOfProductImages;

  ProductImageViewScreenArgument({
    required this.listOfProductImages,
  });
}

class ProductImageViewScreen extends StatelessWidget {
  static const String route = "/product_image_view_screen";

  const ProductImageViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as ProductImageViewScreenArgument;
    var theme = Theme.of(context);

    List<List<ImageData>> imageList = [];
    imageList.add(
        (List.generate(args.listOfProductImages.length, (index) => ImageData(index, args.listOfProductImages[index]))));
    return SafeArea(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CshGalleryView(
            imageList: imageList,
            galleryViewAxis: Axis.horizontal,
          ),
          Positioned(
            right: Dimens.space_20,
            top: Dimens.space_20,
            child: CshIcon(
              FeatherIcons.x,
              padding: EdgeInsets.zero,
              iconSize: MobileIconSize.large,
              iconColor: theme.cardColor,
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
