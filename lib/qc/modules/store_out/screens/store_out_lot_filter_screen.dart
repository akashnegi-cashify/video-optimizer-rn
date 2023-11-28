import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/models/lot_type_list_comp_params.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';

part 'store_out_lot_filter_screen.g.dart';

@CshPage(
    key: StoreOutLotFilterScreen.pageKey,
    pageGroup: QcPageGroup.qcStoreOutLotFilterPageKey,
    params: LotTypeListCompParamKeys.values)
class StoreOutLotFilterScreen extends BaseScreen<StoreOutLotFilterScreenArguments> {
  static const String pageKey = "QC_qc_store_out_lot_filter";
  static const String route = "/store-out-lot-filter";

  const StoreOutLotFilterScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arguments = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: arguments?.toJson(),
    );
  }

  static Future navigate(BuildContext context, {List<String>? selectedLotType}) {
    return Navigator.pushNamed(context, route, arguments: StoreOutLotFilterScreenArguments(selectedLotType));
  }
}

class StoreOutLotFilterScreenArguments extends BaseArguments {
  final List<String>? selectedLotType;
  final String header;

  StoreOutLotFilterScreenArguments(this.selectedLotType, {this.header = "Lot Type"})
      : super(StoreOutLotFilterScreen.pageKey);

  Map<String, dynamic>? toJson() => {
        LotTypeListCompParamKeys.lotType.value: selectedLotType,
        LotTypeListCompParamKeys.header.value: header,
      };
}
