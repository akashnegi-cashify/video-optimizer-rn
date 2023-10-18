import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/resources/device_dead_repair_reason_list_response.dart';
import '../../../../src/common/resources/device_mark_response.dart';
import '../resources/index.dart';

class DeviceDeadAcceptRejectProvider extends CshChangeNotifier {
  final int? markId;
  final String? barcode;
  final String? preSelectedRemark;

  late TextEditingController skuTextEditingController;
  late List<String> _skuList;

  late DataState<DeviceDeadRepairReasonListResponse> deadReasonList;
  late List<DropDownItem<bool>> level;
  late List<RadioListItem> remarkList;

  DeviceDeadAcceptRejectProvider({this.markId, this.barcode, this.preSelectedRemark}) {
    _skuList = [];
    remarkList = [];
    level = [
      DropDownItem(null, "Select engineer", extraData: true),
      DropDownItem("Send to L1", "Send to L1", extraData: false),
      DropDownItem("Send to L2", "Send to L2", extraData: false),
      DropDownItem("Send to L3", "Send to L3", extraData: false)
    ];
    skuTextEditingController = TextEditingController();
    deadReasonList = DataState();
    fetchDeadReasonList();
  }

  bool _isTextFieldEmpty = true;

  static DeviceDeadAcceptRejectProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeviceDeadAcceptRejectProvider>(context, listen: listen);
  }

  bool get isTextFieldEmpty => _isTextFieldEmpty;

  List<String> get skuList => _skuList;

  set isTextFieldEmpty(bool value) {
    if (_isTextFieldEmpty != value) {
      _isTextFieldEmpty = value;
      notifyListeners();
    }
  }

  Stream<AddRemovePartResponse?> addRemovePart(String sku, bool isAddPart) =>
      DeviceDeadRepairServices.addRemovePart(AddRemovePartRequest(sku: sku, id: markId), isAddPart);

  Stream<DeviceMarkResponse?> submitDeadDeviceRequest(AcceptRejectDeadRequest request) =>
      DeviceDeadRepairServices.submitDeadDeviceRequest(request);

  void fetchDeadReasonList() {
    DeviceDeadRepairServices.fetchAcceptDeadReasonList().listen((event) {
      deadReasonList = deadReasonList.copyWith(status: RequestStatus.success, data: event);
      remarkList = event?.data?.map((e) => RadioListItem(e, e, false)).toList() ?? [];
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      Logger.debug('DeviceDeadAcceptRejectProvider.fetchDeadReasonList', [errorMsg]);
      deadReasonList = deadReasonList.copyWith(status: RequestStatus.failure, data: null, errorMsg: errorMsg);
      notifyListeners();
    });
  }

  void addSku(String value) {
    _skuList.add(value);
    notifyListeners();
  }

  void removeSku(String value) {
    _skuList.remove(value);
    notifyListeners();
  }

  void onLevelChange(DropDownItem item) {
    var preSelectedIndex = level.indexWhere((element) => element.extraData == true);
    if (preSelectedIndex != -1) {
      level[preSelectedIndex].extraData = false;
    }
    item.extraData = true;
    notifyListeners();
  }


  void onRemarkChange(RadioListItem item) {
    var preSelectedItem = getSelectedRemark();
    if (preSelectedItem != null) {
      preSelectedItem.isSelected = false;
    }
    item.isSelected = true;
    notifyListeners();
  }

  DropDownItem getSelectedLevel() {
    var preSelectedIndex = level.firstWhere((element) => element.extraData == true);
    return preSelectedIndex;
  }

  RadioListItem? getSelectedRemark() {
    var preSelectedIndex = remarkList.indexWhere((element) => element.isSelected == true);
    return preSelectedIndex != -1 ? remarkList[preSelectedIndex] : null;
  }
}
