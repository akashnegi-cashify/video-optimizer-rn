import 'package:collection/collection.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAgentProvider extends CshChangeNotifier {
  final List<String> _agentList;
  late List<DropDownItem<bool>> _agentDropDownList;
  late TextEditingController textEditingController;

  AddAgentProvider(this._agentList) {
    _agentList.insert(0, "Select Agent");
    textEditingController = TextEditingController();
    _agentDropDownList = _agentList.mapIndexed((index, e) => DropDownItem('$index', e, extraData: false)).toList();
  }

  static AddAgentProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AddAgentProvider>(context, listen: listen);
  }

  List<DropDownItem<bool>> get agentList => _agentDropDownList;

  DropDownItem<bool> get selectedAgent =>
      _agentDropDownList.firstWhere((element) => element.extraData == true, orElse: () => _agentDropDownList[0]);

  void onAgentSelectionChange(DropDownItem<bool> item) {
    var preSelectedItem = selectedAgent;
    preSelectedItem.extraData = false;
    item.extraData = true;
    notifyListeners();
  }

}
