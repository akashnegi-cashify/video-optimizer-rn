import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/no_usage.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../elss_trc/l10n.dart';
import 'network_image_widget.dart';

@NoUsage(reason: "It is not longer used as we remove image capturing of spare parts from TRC ELSS")
class AddMediaCards extends StatefulWidget {
  final String? imageUrl;
  final int index;
  final Function(int, String) setS3UrlToList;

  AddMediaCards({
    Key? key,
    required this.index,
    required this.setS3UrlToList,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<AddMediaCards> createState() => _AddMediaCardsState();
}

class _AddMediaCardsState extends State<AddMediaCards> {
  String? _selectedImageUrl;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    scheduleMicrotask(() {
      _selectedImageUrl = widget.imageUrl;
      setState(() {});
    });
    super.initState();
  }

  _getCompressedImage(File imageFile) async {
    await ImageUtil.compressImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Dimens.space_120,
        alignment: Alignment.center,
        color: theme.cardColor,
        child: (_selectedImageUrl != null && _selectedImageUrl!.isNotEmpty)
            ? fetchImage(
                "assets/images/placeholder.png",
                _selectedImageUrl,
                isUseCacheImage: false,
              )
            : GestureDetector(
                onTap: () async {
                  try {
                    XFile? imageFilex = await picker.pickImage(source: ImageSource.camera);
                    if (imageFilex != null) {
                      CshLoading().showLoading(context);
                      var compressedFile = await ImageUtil.compressImage(File(imageFilex.path));
                      String fileName = path.basename(compressedFile.path);
                      MediaUploadUtil(service: ImageUploadServiceType.trc.service)
                          .uploadMediaWithType(mediaFile: compressedFile, fileName: fileName)
                          .then((value) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.success(context: context, message: l10n.imageUploadedSuccessfully);
                        _selectedImageUrl = value;

                        setState(() {});
                        widget.setS3UrlToList(widget.index, value);
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error.toString());
                      });
                    }
                  } catch (e) {
                    CshSnackBar.error(context: context, message: e.toString());
                  }
                },
                child: CshIcon(
                  FeatherIcons.plusCircle,
                  iconSize: MobileIconSize.xxLarge,
                  iconColor: theme.disabledColor,
                ),
              ),
      ),
    );
  }
}
