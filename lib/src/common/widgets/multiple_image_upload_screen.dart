import 'dart:async';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/loading_dialog_widget.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MultipleImageUploadScreen extends StatefulWidget {
  final Future<void> Function()? callStatusUpdateApi;
  final Function()? onMediaUploaded;
  final DeviceMediaType mediaType;
  final String deviceBarcode;
  final bool isImageMarkingRequired;

  static String route = "/multiple_image_upload_screen";

  const MultipleImageUploadScreen(this.mediaType, this.deviceBarcode,
      {super.key, this.callStatusUpdateApi, this.onMediaUploaded, this.isImageMarkingRequired = false});

  @override
  State<MultipleImageUploadScreen> createState() => _MultipleImageUploadScreenState();
}

class _MultipleImageUploadScreenState extends State<MultipleImageUploadScreen> {
  List<String> _imageList = [""];
  var imagePicker = ImagePicker();
  var isStatusApiUpdated = false;

  @override
  Widget build(BuildContext context) {
    var cardSize = MediaQuery.of(context).size.width / 2 - 32;
    return Scaffold(
        appBar: const QcGeneralHeader("Upload Media", showBackBtn: true),
        body: Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  key: ValueKey(_imageList.length.toString()),
                  itemCount: _imageList.length,
                  itemBuilder: (context, index) {
                    var item = _imageList[index];
                    return ChangeNotifierProvider(
                      create: (_) => ImageUploadProvider(s3Url: item),
                      child: GeneralImageUploadCard(
                        cardHeight: cardSize,
                        cardWidth: cardSize,
                        imageUrl: item,
                        isImageMarkingRequired: widget.isImageMarkingRequired,
                        onImageDelete: () {
                          setState(() {
                            _imageList.removeAt(index);
                          });
                          Future.delayed(const Duration(milliseconds: 500)).then((value) {
                            setState(() {
                              if (!Validator.isNullOrEmpty(_imageList.last)) {
                                _imageList.add("");
                              }
                            });
                          });
                        },
                        onMediaUploadingStarted: () {
                          setState(() {
                            if (_imageList.length < 8 && index == _imageList.length - 1) {
                              _imageList.add("");
                            }
                          });
                        },
                        onMediaUploaded: (url) {
                          setState(() {
                            _imageList[index] = url!;
                          });
                        },
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              SizedBox(
                width: double.infinity,
                child: CshBigButton(
                  text: "Submit",
                  onPressed: _imageList.first.isNotEmpty
                      ? () {
                          if (isStatusApiUpdated) {
                            _updateMedia();
                          } else {
                            CshLoading().showLoading(context);
                            widget.callStatusUpdateApi?.call().then((value) {
                              isStatusApiUpdated = true;
                              CshLoading().hideLoading(context);
                              _updateMedia();
                            }, onError: (error) {
                              CshLoading().hideLoading(context);
                              CshSnackBar.error(context: context, message: error.toString());
                            });
                          }
                        }
                      : null,
                ),
              )
            ],
          ),
        ));
  }

  _updateMedia() {
    var validImageUrls = _imageList.where((element) => element.isNotEmpty).toList();
    EngineerAPIService.updateMedia(widget.mediaType.val, validImageUrls, widget.deviceBarcode).doAsyncOp(
      (value) {
        widget.onMediaUploaded?.call();
      },
      (loading) {
        if (loading) {
          CshLoading().showLoading(context);
        } else {
          CshLoading().hideLoading(context);
        }
      },
      (e, s) {
        CshSnackBar.error(context: context, message: e.toString());
      },
    );
  }
}

enum DeviceMediaType {
  markOk(1),
  markToTl(2),
  screwSealImages(3),
  markFail(5),
  glassChange(6);

  final int val;

  const DeviceMediaType(this.val);
}
