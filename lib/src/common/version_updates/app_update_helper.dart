import 'dart:convert';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/version_updates/app_version_response.dart';
import 'package:flutter_trc/src/common/version_updates/version.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/libraries/url_launcher/csh_url_launcher.dart';
import 'package:flutter_trc/src/utils/app_util.dart';

import '../l10n.dart';

class AppUpdateHelper {
  static checkAppVersion(BuildContext context, {required VoidCallback onProceed}) async {
    String? currentAppVersionString = await AppUtil.getAppVersionName();
    if (currentAppVersionString == null) {
      CshSnackBar.error(context: context, message: "Unable to get app version");
      return;
    }
    AppVersionResponse response = AppVersionResponse.fromJson(
        jsonDecode(RemoteConfigHelper().getString(AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS)));

    try {
      var latestVersionData = response.versionList?.last;
      var latestVersion = Version.parse(latestVersionData?.versionName);
      var currentVersion = Version.parse(currentAppVersionString);

      if (currentVersion < latestVersion && latestVersionData != null && context.mounted) {
        _showVersionDialog(context, latestVersionData, onProceed);
      } else {
        onProceed();
      }
    } catch (e) {
      Logger.debug('mydebug-----AppUpdateHelper.checkAppVersion', [e]);
      CshSnackBar.error(context: context, message: "Unable to get app version");
    }
  }

  static _showVersionDialog(BuildContext context, AppVersionData appVersionData, VoidCallback onProceed) async {
    L10n l10n = L10n(context, listen: false);

    String title = l10n.newVersionAvailable;
    String message = l10n.majorVersionDescription;
    String btnLabel = l10n.update;
    String btnLabelCancel = l10n.cancel;
    return _showPopup(
      context,
      barrierDismissible: false,
      title: title,
      desc: message,
      actions: <Widget>[
        CshMediumButton(
          text: btnLabel,
          onPressed: () {
            CshUrlLauncher.launchURL(context, appVersionData.apkUrl!);
          },
        ),
        if (!Validator.isTrue(appVersionData.isMajorUpdate))
          CshMediumButton(
            text: btnLabelCancel,
            onPressed: () {
              Navigator.pop(context); // dismiss dialog
              onProceed();
            },
          ),
      ],
    );
  }

  static void _showPopup(
    BuildContext context, {
    String? title,
    String? desc,
    List<Widget>? actions,
    bool barrierDismissible = false,
    Function(BuildContext context)? onBackPressDismiss,
  }) async {
    ThemeData theme = Theme.of(context);
    Widget alert(BuildContext context) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: theme.primaryTextTheme.headlineMedium,
                )
              : null,
          content: desc != null
              ? Text(
                  desc,
                  style: theme.primaryTextTheme.titleSmall,
                )
              : null,
          actions: actions,
        ),
      );
    }

    // show the dialog
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alert(context);
      },
    );
  }
}
