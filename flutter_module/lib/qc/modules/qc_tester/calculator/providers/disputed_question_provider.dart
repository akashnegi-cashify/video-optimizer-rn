import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:provider/provider.dart';


class DisputedQuestionProvider extends CshChangeNotifier {
  static DisputedQuestionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DisputedQuestionProvider>(context, listen: listen);
  }

  final List<ManualAuditQuestionItem>? _disputedQuestionList;

  List<ManualAuditQuestionItem>? get disputedQuestionList => _disputedQuestionList;

  DisputedQuestionProvider(this._disputedQuestionList);

  void updateQuestionList(int index, bool? value) {
    var item = _disputedQuestionList?[index];
    item?.isSelected = value;
    notifyListeners();
  }

  List<int> getSelectedQuestionList() {
    List<int> list = [];
    var selectedList = _disputedQuestionList?.where((element) => element.isSelected == true).toList();
    if (selectedList != null) {
      for (var element in selectedList) {
        list.add(element.manualMasterId!);
      }
    }
    return list;
  }
}
