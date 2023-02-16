import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../amplify/amplifier.dart';
import '../../../../amplify/amplify_provider.dart';
import '../../common_models/elss_part.dart';
import '../l10n.dart';
import 'option_sku_tile_widget.dart';

class OptionNotAllowedModal extends StatefulWidget {
  final List<ElssPart>? dataList;
  final Function() onSubmitCallback;
  final Function(int, String)? onAttachS3UrlToSku;

  const OptionNotAllowedModal({
    Key? key,
    this.dataList,
    required this.onSubmitCallback,
    this.onAttachS3UrlToSku,
  }) : super(key: key);

  @override
  State<OptionNotAllowedModal> createState() => _OptionNotAllowedModalState();
}

class _OptionNotAllowedModalState extends State<OptionNotAllowedModal> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.listOfSkUs,
            style: theme.primaryTextTheme.headline2,
          ),
          (!Validator.isListNullOrEmpty(widget.dataList))
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
                    itemBuilder: (context, index) {
                      return OptionSkuTileWidget(
                        (index + 1),
                        dataModel: widget.dataList![index],
                        onImageUpload: () async {
                          try {
                            XFile? imageFilex = await picker.pickImage(source: ImageSource.camera);
                            if (imageFilex != null) {
                              AmplifyProvider amplifyProvider = AmplifyProvider.of(context, listen: false);
                              File imageFile = File(imageFilex.path);
                              String fileName = Amplifier.fileNameFromPath(imageFile.path);
                              CshLoading().showLoading(context);
                              amplifyProvider.uploadFile(
                                fileName: fileName,
                                folderName: amplifyProvider.qcConfigResponse?.folderName,
                                file: imageFile,
                                onProgress: (int currentBytes, int totalBytes) {},
                                onFileUploaded: (String imagePath) async {
                                  CshLoading().hideLoading(context);

                                  String s3Key = imagePath;
                                  if (!Validator.isNullOrEmpty(s3Key)) {
                                    String s3Url =
                                        await amplifyProvider.getS3FileUrlFromS3Key(filePath: s3Key, fullPath: false);
                                    CshSnackBar.success(
                                      context: context,
                                      message: l10n.imageUploadedSuccessfully,
                                      snackBarPosition: SnackBarPosition.TOP,
                                    );
                                    if (widget.onAttachS3UrlToSku != null) {
                                      widget.onAttachS3UrlToSku!(index, s3Url);
                                    }
                                    widget.dataList![index].imageS3Url = s3Url;

                                    setState(() {});
                                  }
                                },
                                onFailed: (String errorMsg) {
                                  CshLoading().hideLoading(context);
                                  CshSnackBar.error(
                                    context: context,
                                    message: errorMsg,
                                    snackBarPosition: SnackBarPosition.TOP,
                                  );
                                },
                              );
                            }
                          } catch (e) {
                            CshSnackBar.error(
                              context: context,
                              message: e.toString(),
                              snackBarPosition: SnackBarPosition.TOP,
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: widget.dataList!.length,
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.submit,
              onPressed: _checkIfImageAttachedWithEverySKU() ? widget.onSubmitCallback : null,
            ),
          )
        ],
      ),
    );
  }

  _checkIfImageAttachedWithEverySKU() {
    if (!Validator.isListNullOrEmpty(widget.dataList)) {
      for (var element in widget.dataList!) {
        if (Validator.isNullOrEmpty(element.imageS3Url)) {
          setState(() {});
          return false;
        }
      }
      setState(() {});
      return true;
    }
  }
}
