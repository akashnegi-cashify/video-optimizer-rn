import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/user/widget/user_profile_action_widget.dart';
import 'package:flutter_trc/src/libraries/alice/csh_alice.dart';

import '../../../../common/user/widget/logout_action_widget.dart';
import '../../../../environments/environment_config.dart';

class QcGeneralHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showBackBtn;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? showLogoutButton;
  final bool? showProfileButton;

  const QcGeneralHeader(
    this.title, {
    Key? key,
    this.actions,
    this.bottom,
    this.showBackBtn = true,
    this.showLogoutButton = false,
    this.titleWidget,
    this.showProfileButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsList = [
      if (Validator.isTrue(environment?.enableAlice))
        CshIcon(
          FeatherIcons.info,
          iconColor: Colors.amber,
          iconSize: MobileIconSize.medium,
          padding: EdgeInsets.zero,
          onClick: () {
            CshAlice().alice?.showInspector();
          },
        ),
      // CshIcon(
      //   FeatherIcons.externalLink,
      //   iconColor: Colors.amber,
      //   iconSize: MobileIconSize.medium,
      //   padding: EdgeInsets.zero,
      //   onClick: () {
      //     LoggingService.showLogScreen(context);
      //   },
      // ),
      if (Validator.isTrue(showLogoutButton)) const LogoutActionWidget(),
      if (Validator.isTrue(showProfileButton)) const UserProfileActionWidget(),
      if (!Validator.isListNullOrEmpty(actions)) ...actions!
    ];
    return CshHeader(
      title,
      showBackBtn: showBackBtn ?? true,
      bottom: bottom,
      actions: actionsList,
      child: titleWidget,
    );
  }

  // String _getConfigInString() {
  //   return RemoteConfigHelper().getString(AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C);
  // }
  //
  // _temp(BuildContext context) {
  //   var picker = ImagePicker();
  //   picker.pickVideo(source: ImageSource.gallery).then((value) async {
  //     if (value != null) {
  //       File(value.path).logFileSize();
  //       VideoPlayerController videoPlayerController = VideoPlayerController.file(File(value.path));
  //       await videoPlayerController.initialize();
  //       var date = DateTime.now();
  //       VideoUtil.compressVideo(value.path, videoPlayerController.value.duration.inSeconds, configString: _getConfigInString(), onProgress: (value) {
  //         // _fileCompressProgressStream.add(value);
  //       })
  //           .then((String? outputPath) {
  //         if (outputPath != null) {
  //           var date1 = DateTime.now();
  //           Logger.debug('mydebug-----QcGeneralHeader._temp', [date1.difference(date).inMilliseconds.toString()]);
  //           File(outputPath).logFileSize();
  //
  //           MediaUploadUtil()
  //               .uploadMediaWithType(
  //                   mediaFile: File(outputPath), fileName: "temp.mp4", contentType: MediaContentType.mp4)
  //               .then((value) {
  //             Logger.debug('mydebug-----QcGeneralHeader._temp final Url', [value]);
  //           });
  //
  //           // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //           //   return VideoPreview(filePath: outputPath);
  //           // },));
  //           // _compressedFilePath = outputPath;
  //         }
  //       }, onError: (error) {
  //         Logger.debug('mydebug-----QcGeneralHeader._temp', [error.toString()]);
  //       });
  //     }
  //   });
  // }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
