import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import '../../../../src/utils/media_upload/resource/media_content_type.dart';
import '../l10n.dart';
import '../providers/upload_eway_bill_provider.dart';

class UploadEwayBillWidget extends StatefulWidget {
  final int? facilityId;
  final String? shipmentId;

  const UploadEwayBillWidget({
    super.key,
    this.facilityId,
    this.shipmentId,
  });

  @override
  State<UploadEwayBillWidget> createState() => _UploadEwayBillWidgetState();
}

class _UploadEwayBillWidgetState extends State<UploadEwayBillWidget> {
  final TextEditingController _awbController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _dateString, _timeString, _docS3Url;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CshTextFormField(
            controller: _awbController,
            maxLines: 1,
            maxLength: 100,
            keyboardType: TextInputType.text,
            hintText: l10n.awbNumber,
          ),
          const SizedBox(height: Dimens.space_16),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 3650),
                ),
              ).then((value) {
                if (value != null) {
                  _selectedDate = value;
                  _dateString = DateFormat("dd MMM yyyy").format(value);
                  setState(() {});
                }
              });
            },
            child: Container(
              width: double.infinity,
              height: Dimens.space_50,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  border: Border.all(color: theme.shadowColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(Dimens.space_4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_dateString ?? l10n.date, style: theme.primaryTextTheme.bodyMedium),
                  CshIcon(
                    FeatherIcons.calendar,
                    padding: EdgeInsets.zero,
                    iconSize: MobileIconSize.medium,
                    iconColor: theme.primaryColor,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_30),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute))
                  .then((value) {
                if (value != null) {
                  _selectedTime = value;
                  _timeString = DateFormat("hh:mm aa").format(DateTime(
                      DateTime.now().year, DateTime.now().month, DateTime.now().day, value.hour, value.minute));
                  setState(() {});
                }
              });
            },
            child: Container(
              width: double.infinity,
              height: Dimens.space_50,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  border: Border.all(color: theme.shadowColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(Dimens.space_4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_timeString ?? l10n.time, style: theme.primaryTextTheme.bodyMedium),
                  CshIcon(
                    FeatherIcons.clock,
                    padding: EdgeInsets.zero,
                    iconSize: MobileIconSize.medium,
                    iconColor: theme.primaryColor,
                  )
                ],
              ),
            ),
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
          const Expanded(
            child: SizedBox.shrink(),
          ),
          ComboButton(
            firstBtnText: l10n.cancel,
            secondBtnText: l10n.save,
            buttonType: ButtonType.mini,
            isFirstPrimary: true,
            padding: EdgeInsets.zero,
            firstBtnClick: () => Navigator.of(context).pop(),
            secondBtnClick: () {
              if (_awbController.text.isEmpty) {
                CshSnackBar.error(context: context, message: "AWB Number is required");
              } else if (_docS3Url == null) {
                CshSnackBar.error(context: context, message: "Upload Media to proceed further");
              } else {
                _uploadEWayBill();
              }
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
                    File selectedFile = File(data.path);
                    ImageUtil.compressImage(selectedFile).then((targetFile) {
                      selectedFile = targetFile;
                    }).whenComplete(() {
                      Navigator.of(context).pop();
                      _uploadMediaWithContentType(selectedFile, MediaContentType.jpeg);
                    });
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
                  Navigator.of(context).pop();
                  try {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg', 'pdf']);
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      if (file.extension == "pdf") {
                        _uploadMediaWithContentType(File(file.path ?? ""), MediaContentType.pdf);
                      } else if (file.extension == "png") {
                        _uploadMediaWithContentType(File(file.path ?? ""), MediaContentType.png);
                      } else if (file.extension == "jpeg") {
                        _uploadMediaWithContentType(File(file.path ?? ""), MediaContentType.jpeg);
                      } else if (file.extension == "jpg") {
                        _uploadMediaWithContentType(File(file.path ?? ""), MediaContentType.jpg);
                      } else {
                        _uploadMediaWithContentType(File(file.path ?? ""), MediaContentType.jpeg);
                      }
                    }
                  } catch (e) {
                    CshSnackBar.error(context: context, message: e.toString());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _uploadMediaWithContentType(File data, MediaContentType value) {
    CshLoading().showLoading(context);
    String fileName = path.basename(data.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: data, fileName: fileName, contentType: value).then((value) {
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

  _uploadEWayBill() {
    CshLoading().showLoading(context);
    var provider = UploadEwayBillProvider.of(context, listen: false);
    provider
        .uploadEwayBill(_awbController.text.trim(), _docS3Url ?? "", widget.facilityId ?? 0, widget.shipmentId ?? "")
        .then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Uploaded successfully");
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
