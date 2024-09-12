import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_parts_selection_options.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:provider/provider.dart';

class PartRequestReasonsProvider extends CshChangeNotifier {
  List<OrderEngineerPart> partRequestList = [];

  List<Reasons>? _reasons;
  List<DropDownItem<Reasons>> reasonsDropdownList = [];

  static PartRequestReasonsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartRequestReasonsProvider>(context, listen: listen);
  }

  PartRequestReasonsProvider(this.partRequestList) {
    // TODO: dummy data, need data from api
    _reasons = [
      Reasons("1", "Reason 1", true),
      Reasons("2", "Reason 2", false),
      Reasons("3", "Reason 3", true),
      Reasons("4", "Reason 4", false),
      Reasons("5", "Reason 5", true),
    ];

    reasonsDropdownList = _reasons!.map((e) => DropDownItem<Reasons>(e.id, e.name, extraData: e)).toList();
  }

  bool isReasonRequired(OrderEngineerPart item) {
    // TODO: add categoryCode Condition
    return ElssPartsSelectionOptions.getEnumById(item.partType) == ElssPartsSelectionOptions.repairRequired;
  }

  void updatePartRequestItem(OrderEngineerPart item) {
    int index = partRequestList.indexWhere((element) => element.sku == item.sku && element.partColor == item.partColor);
    partRequestList[index] = item;
    notifyListeners();
  }

  bool isAllReasonsSelected() {
    for (var item in partRequestList) {
      if (!isReasonRequired(item)) {
        continue;
      }

      /// If reasons is not selected
      if (Validator.isNullOrEmpty(item.reasonId)) {
        return false;
      }
      bool isImageRequired = _reasons?.firstWhere((element) => element.id == item.reasonId).imageRequired ?? false;

      /// If reasons is selected but image is required and not uploaded
      if (isImageRequired && Validator.isListNullOrEmpty(item.imageList)) {
        return false;
      }

      /// If reasons is selected but image is empty
      if (isImageRequired && Validator.isNullOrEmpty(item.imageList?.first)) {
        return false;
      }
    }
    return true;
  }
}

class Reasons {
  String? id;
  String? name;
  bool? imageRequired;

  Reasons(this.id, this.name, this.imageRequired);
}
