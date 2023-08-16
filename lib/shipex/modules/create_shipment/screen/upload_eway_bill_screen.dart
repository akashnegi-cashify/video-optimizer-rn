import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/upload_eway_bill_param.dart';
import '../providers/upload_eway_bill_provider.dart';

part 'upload_eway_bill_screen.g.dart';

@CshPage(
    key: UploadEwayBillScreen.pageKey,
    pageGroup: PageGroup.uploadEwayBillPageKey,
    params: UploadEwayBillParamsKeys.values)
class UploadEwayBillScreenArguments extends BaseArguments {
  final int? facilityId;
  final String? shipmentId;

  UploadEwayBillScreenArguments({this.facilityId, this.shipmentId}) : super(UploadEwayBillScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      UploadEwayBillParamsKeys.shipmentId.value: shipmentId,
      UploadEwayBillParamsKeys.facilityId.value: facilityId,
    };
  }
}

class UploadEwayBillScreen extends BaseScreen<UploadEwayBillScreenArguments> {
  static const String pageKey = "upload_eway_bill_screen";
  static const String route = "/upload_eway_bill_screen";

  const UploadEwayBillScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
      setProviders: (BuildContext insideContext) {
        return [
          ChangeNotifierProvider<UploadEwayBillProvider>(
            create: (_) => UploadEwayBillProvider(),
            lazy: false,
          ),
        ];
      },
    );
  }
}
