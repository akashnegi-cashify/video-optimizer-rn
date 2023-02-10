import 'dart:async';
import 'dart:io';

import '../../../amplify/amplifier.dart';
import '../../../amplify/amplify_provider.dart';
import '../elss_trc/l10n.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'network_image_widget.dart';

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
                      AmplifyProvider amplifyProvider = AmplifyProvider.of(context, listen: false);
                      File imageFile = File(imageFilex.path);
                      String fileName = Amplifier.fileNameFromPath(imageFile.path);

                      CshLoading().showLoading(context);
                      amplifyProvider.uploadFile(
                        fileName: fileName,
                        folderName: amplifyProvider.configResponse?.data?.folderName,
                        file: imageFile,
                        onProgress: (int currentBytes, int totalBytes) {},
                        onFileUploaded: (String imagePath) async {
                          CshLoading().hideLoading(context);

                          String s3Key = imagePath;
                          if (!Validator.isNullOrEmpty(s3Key)) {
                            String s3Url = await amplifyProvider.getS3FileUrlFromS3Key(filePath: s3Key, fullPath: true);
                            CshSnackBar.success(context: context, message: l10n.imageUploadedSuccessfully);
                            _selectedImageUrl = s3Url;

                            setState(() {});
                            widget.setS3UrlToList(widget.index, s3Url);
                          }
                        },
                        onFailed: (String errorMsg) {
                          CshLoading().hideLoading(context);
                          CshSnackBar.error(context: context, message: errorMsg);
                        },
                      );
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
