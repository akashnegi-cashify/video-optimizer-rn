import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_store_out_param_model.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'storage_device_list_screen.g.dart';

class StorageDeviceListScreenArg extends BaseArguments {
  int? lotId;

  StorageDeviceListScreenArg(this.lotId) : super(StorageDeviceListScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {StStoreOutParamModelKeys.lotId.value: lotId};
  }
}

@CshPage(
    key: StorageDeviceListScreen.pageKey,
    pageGroup: QcPageGroup.qcStorageDeviceListPageKey,
    params: StStoreOutParamModelKeys.values)
class StorageDeviceListScreen extends BaseScreen<StorageDeviceListScreenArg> {
  static const String pageKey = "QC_storage_device_list_screen";
  static const String route = "/storage_device_list_screen";

  const StorageDeviceListScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arguments = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arguments?.toJson());
  }

  static pushNamed(BuildContext context, int lotId, {Function(StLotDetailResponse item)? onItemSelected}) {
    Navigator.pushNamed(context, route, arguments: StorageDeviceListScreenArg(lotId)).then((value) {
      if (value != null && value is StLotDetailResponse) {
        onItemSelected?.call(value);
      }
    });
  }
}
