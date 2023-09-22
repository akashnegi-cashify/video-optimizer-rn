import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../models/media_file_upload_comp_params.dart';
import '../models/validate_awb_response.dart';

part 'media_file_upload_screen.g.dart';

class MediaFileUploadScreenArguments extends BaseArguments {
  Map<String, Items> items;

  MediaFileUploadScreenArguments(
    super.pageKey,
    this.items,
  );
}

@CshPage(
  key: MediaFileUploadScreen.pageKey,
  params: MediaFileUploadCompParamKeys.values,
)
// todo ask page grp

class MediaFileUploadScreen extends BaseScreen<MediaFileUploadScreenArguments> {
  static const String pageKey = "QC_qc_media_file_upload";
  static const String route = "/media-file-upload";

  const MediaFileUploadScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: {MediaFileUploadCompParamKeys.selectedOptionItems.value: args?.items},
    );
  }

  static Future navigate(BuildContext context, Map<String, Items> items) {
   return Navigator.pushNamed(context, route, arguments: MediaFileUploadScreenArguments(pageKey, items));
  }
}
