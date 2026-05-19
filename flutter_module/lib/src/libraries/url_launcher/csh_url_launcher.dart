import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CshUrlLauncher {
  static Future<bool> launchURL(BuildContext context, String url,
      {String? errorMessage, LaunchMode launchMode = LaunchMode.externalApplication}) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: launchMode);
    } else {
      // This block should not called, handle extra case.
      CshSnackBar.error(context: context, message: errorMessage ?? "There is some problem in opening url");
      return Future.error(errorMessage.toString());
    }
  }
}
