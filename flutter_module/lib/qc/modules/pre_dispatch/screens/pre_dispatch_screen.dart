import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../models/index.dart';

part 'pre_dispatch_screen.g.dart';

@CshPage(key: PreDispatchScreen.pageKey, pageGroup: QcPageGroup.qcPreDispatch)
class PreDispatchScreen extends BaseScreen<PreDispatchScreenArgs> {
  static const String pageKey = "QC_qc_pre_dispatch";
  static const String route = "/pre-dispatch";

  const PreDispatchScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }

  static Future navigate(BuildContext context, String? lotGroupName, int? lotId, VoidCallback? allScanDoneCallback) {
    return Navigator.pushNamed(
      context,
      PreDispatchScreen.route,
      arguments: PreDispatchScreenArgs(
        pageKey,
        lotGroupName,
        lotId,
        allScanDoneCallback,
      ),
    );
  }
}

class PreDispatchScreenArgs extends BaseArguments {
  PreDispatchScreenArgs(super.pageKey, this.lotGroupName, this.lotId, this.allScanDoneCallback);

  final String? lotGroupName;
  final int? lotId;
  final VoidCallback? allScanDoneCallback;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[PreDispatchCompParamKeys.lotGroupName.value] = lotGroupName;
    data[PreDispatchCompParamKeys.lotId.value] = lotId;
    data[PreDispatchCompParamKeys.allScanDoneCallback.value] = allScanDoneCallback;
    return data;
  }
}
