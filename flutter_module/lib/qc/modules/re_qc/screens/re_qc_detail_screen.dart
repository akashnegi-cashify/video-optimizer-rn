import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_detail_param.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 're_qc_detail_screen.g.dart';

@CshPage(key: ReQcDetailScreen.pageKey, pageGroup: QcPageGroup.qcReQcDetailPageKey, params: ReQcDetailParamKeys.values)
class ReQcDetailScreenArguments extends BaseArguments {
  final ReQcListData? reQcListData;

  ReQcDetailScreenArguments(this.reQcListData) : super(ReQcDetailScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      ReQcDetailParamKeys.reQcListData.value: reQcListData,
    };
  }
}

class ReQcDetailScreen extends BaseScreen<ReQcDetailScreenArguments> {
  static const String pageKey = "QC_re_qc_detail_screen";
  static const String route = "/re-qc/detail/";

  const ReQcDetailScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arguments = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arguments?.toJson());
  }
}
