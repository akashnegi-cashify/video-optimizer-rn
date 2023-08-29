import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:image/image.dart' as Im;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../src/modules/elss/common_screen/elss_home_screen.dart';
import '../../qc_tester/home/screens/qc_tester_home_screen.dart';
import '../l10n.dart';
import '../models/qc_action_comp_config.dart';

class QCActionWidget extends StatelessWidget {
  final QcActionConfig? configData;

  const QCActionWidget({
    Key? key,
    this.configData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QcRolePermissionWidget(
            role: QcRole.qcElss,
            child: SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: configData?.button1Text ?? l10n.elss,
                onPressed: () {
                  ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: true);
                  Navigator.of(context).pushNamed(ElssHomeScreen.route, arguments: args);
                },
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: configData?.button2Text ?? l10n.qcTester,
              onPressed: () {
                Navigator.of(context).pushNamed(QcTesterHomeScreen.route);
              },
            ),
          ),
          // const SizedBox(height: Dimens.space_16),
          // SizedBox(
          //   width: double.infinity,
          //   child: CshMediumButton(
          //     text: "Temp",
          //     onPressed: () async {
          //       var picker = ImagePicker();
          //       var xFile = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);
          //       if (xFile != null) {
          //         // // var videoFile = File(xFile.path);
          //         // // Logger.debug('mydebug-----filesize---', [(videoFile.lengthSync() / (1024 * 1024))]);
          //         // // VideoCompress.compressVideo(xFile.path, includeAudio: false).then((value) async {
          //         // //   if (value?.file != null) {
          //         // //     var newNamedFile = value!.file!.copySync(
          //         // //         join((await getTemporaryDirectory()).path, "${DateTime.now().millisecondsSinceEpoch}.mp4"));
          //         // //     Logger.debug(
          //         // //         'mydebug-----filesize---', [(newNamedFile.lengthSync() / (1024 * 1024)), newNamedFile.path]);
          //         // //     var timeStampFile = await newNamedFile.addTimeStamp();
          //         // //     // var newFile = await value?.file?.addTimeStamp();
          //         // //     // Logger.debug('mydebug-----QCActionWidget.build', [newFile?.path]);
          //         // //     Navigator.push(
          //         // //       context,
          //         // //       MaterialPageRoute(builder: (_) => VideoTimestamp(videoPath: timeStampFile.path)),
          //         // //     );
          //         // //   }
          //         // });
          //
          //         convertToWebP(xFile.path, context);
          //
          //         // _showImage(context);
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  void convertToWebP(path, BuildContext context) async {
    File imagePath = File(path);
    //get temporary directory
    Logger.debug('mydebug-----convertToWebP', [(imagePath.lengthSync() / (1024 * 1024)), imagePath.path]);
    Im.Image? image = Im.decodeImage(imagePath.readAsBytesSync());
    Logger.debug('mydebug-----convertToWebP', [image?.height, image?.width]);

    var targetPath = join((await getTemporaryDirectory()).path, ("${DateTime.now().millisecondsSinceEpoch}.webp"));

    var compressedXFile = await FlutterImageCompress.compressAndGetFile(path, targetPath,
        quality: 90, keepExif: false, format: CompressFormat.webp, minWidth: 1200);
    if (compressedXFile != null) {
      Im.Image? comImage = Im.decodeImage(File(compressedXFile.path).readAsBytesSync());
      Logger.debug('mydebug--compressed---convertToWebP',
          [(File(compressedXFile.path).lengthSync() / (1024 * 1024)), compressedXFile.path]);
      Logger.debug('mydebug--compressed---convertToWebP', [comImage?.height, comImage?.width]);
      MediaUploadUtil()
          .uploadMediaWithType(
              mediaFile: File(compressedXFile.path),
              fileName: DateTime.now().millisecondsSinceEpoch.toString(),
              contentType: MediaContentType.webp)
          .then((value) {
        Logger.debug('mydebug-----convertToWebP', [value]);
      }, onError: (error) {
        Logger.debug('mydebug-----QCActionWidget.jpgTOpng', [error]);
      });
    }
  }
}
