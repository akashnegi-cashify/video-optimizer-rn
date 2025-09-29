import 'package:core_widgets/core_widgets.dart';
import 'package:csh_gallery_view/csh_gallery_view.dart';
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class GalleryScreen extends StatelessWidget {
  static const route = '/gallery_screen';

  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GalleryScreenArguments? arguments;
    if (arguments == null) {
      final GalleryScreenArguments? args = ModalRoute.of(context)?.settings.arguments as GalleryScreenArguments?;
      arguments = args;
    }
    List<List<ImageData>>? images = arguments?.images;

    return Scaffold(
      body: Validator.isListNullOrEmpty(images)
          ? Container()
          : Stack(
              children: [
                CshGalleryView(imageList: images!),
                Positioned(
                  top: Dimens.space_50,
                  right: Dimens.space_16,
                  child: CshIcon(
                    FeatherIcons.xCircle,
                    iconColor: Colors.white,
                    padding: const EdgeInsets.all(Dimens.space_16),
                    onClick: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
    );
  }
}

class GalleryScreenArguments {
  final List<List<ImageData>>? images;

  GalleryScreenArguments(this.images);
}
