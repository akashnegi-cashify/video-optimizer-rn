import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../src/utils/media_upload/media_optimiser_utils.dart';
import '../l10n.dart';
import '../models/create_manual_shipment_param.dart';
import '../models/shipment_provider_list_response.dart';
import '../providers/manual_shipment_provider.dart';

class CreateManualShipmentWidget extends StatefulWidget {
  final CreateManualShipmentParam? params;

  const CreateManualShipmentWidget({
    super.key,
    this.params,
  });

  @override
  State<CreateManualShipmentWidget> createState() => _CreateManualShipmentWidgetState();
}

class _CreateManualShipmentWidgetState extends State<CreateManualShipmentWidget> {
  final TextEditingController _awbController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? _docS3Url;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ManualShipmentProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
      child: Column(
        children: [
          CshTextFormField(
            controller: _awbController,
            hintText: l10n.awbNumber,
            maxLength: 100,
            maxLines: 1,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: Dimens.space_12),
          CshShimmer(
            show: provider.providerDataListLoading || provider.estimatedProviderDataLoading,
            child: (!Validator.isListNullOrEmpty(provider.providerList))
                ? CshDropDown(
                    hintText: l10n.selectBox,
                    onChanged: (DropDownItem data) {
                      provider.onProviderChange(ShipmentProviderListData(key: data.id, name: data.label));
                    },
                    selectedItem: provider.estimatedProvider != null
                        ? DropDownItem(provider.estimatedProvider?.key, provider.estimatedProvider?.name)
                        : null,
                    items: List.generate(
                      provider.providerList!.length,
                      (index) => DropDownItem(provider.providerList![index].key, provider.providerList![index].name),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: Dimens.space_20),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _uploadModal(l10n);
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.space_8),
                border: Border.all(
                  color: _docS3Url != null ? theme.primaryColor : theme.shadowColor.withOpacity(0.5),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      _docS3Url != null ? l10n.documentSelected : l10n.uploadDocument,
                      style: theme.primaryTextTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          ComboButton(
            firstBtnText: l10n.save,
            secondBtnText: l10n.cancel,
            buttonType: ButtonType.mini,
            isFirstPrimary: true,
            padding: EdgeInsets.zero,
            firstBtnClick: () {
              if (_awbController.text.isEmpty) {
                CshSnackBar.error(context: context, message: "AWB Number is required");
              } else if (_docS3Url == null) {
                CshSnackBar.error(context: context, message: "Upload Media to proceed further");
              } else if (provider.selectedProvider == null) {
                CshSnackBar.error(context: context, message: "Select Provider to proceed further");
              } else {
                if (Validator.isTrue(widget.params?.isManualShipment)) {
                  _updateShipment();
                } else {
                  _createManualShipment();
                }
              }
            },
            secondBtnClick: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  _uploadModal(L10n l10n) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: l10n.takeImage,
                onPressed: () async {
                  XFile? data = await _picker.pickImage(source: ImageSource.camera);
                  if (data != null) {
                    Navigator.of(context).pop();
                    _uploadMediaFunc(File(data.path));
                  }
                },
              ),
            ),
            const SizedBox(height: Dimens.space_12),
            SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: l10n.uploadDocument,
                onPressed: () async {
                  Logger.debug('mydebug------_UploadEwayBillWidgetState._uploadModal', ["hgfhfhgfhgfhgf"]);
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.media, allowedExtensions: ['png', 'jpeg', 'jpg', 'pdf']);
                  if (result != null) {
                    Navigator.of(context).pop();
                    PlatformFile file = result.files.first;
                    Logger.debug('mydebug------_UploadEwayBillWidgetState._uploadModal', [file.extension]);
                    if (file.extension == "pdf") {
                      _uploadMediaWithContentType(File(file.path ?? ""));
                    } else {
                      _uploadMediaFunc(File(file.path ?? ""));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _uploadMediaFunc(File data) {
    CshLoading().showLoading(context);
    String fileName = path.basename(data.path);
    MediaUploadUtil().uploadMedia(mediaFile: data, fileName: fileName, isVideoFile: false).then((value) {
      CshLoading().hideLoading(context);
      if (!Validator.isNullOrEmpty(value)) {
        _docS3Url = value;
        setState(() {});
        CshSnackBar.success(context: context, message: "Media Uploaded Successfully!!");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _uploadMediaWithContentType(File data) {
    CshLoading().showLoading(context);
    String fileName = path.basename(data.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: data, fileName: fileName, contentType: "application/pdf").then(
        (value) {
      CshLoading().hideLoading(context);
      if (!Validator.isNullOrEmpty(value)) {
        _docS3Url = value;
        setState(() {});
        CshSnackBar.success(context: context, message: "Media Uploaded Successfully!!");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _createManualShipment() {
    CshLoading().showLoading(context);
    var provider = ManualShipmentProvider.of(context, listen: false);
    provider.createManualShipment(awbNumber: _awbController.text.trim(), docUrl: _docS3Url!).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Shipment Created Successfully!!");
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _updateShipment() {
    CshLoading().showLoading(context);
    var provider = ManualShipmentProvider.of(context, listen: false);
    provider.updateManualShipment(awbNumber: _awbController.text.trim(), docUrl: _docS3Url!).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Shipment Updated Successfully!!");
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
