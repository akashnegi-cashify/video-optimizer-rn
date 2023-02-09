import 'package:core_widgets/core_widgets.dart';

class ReturnPartProvider extends CshChangeNotifier {
  DropDownItem<String>? _selectedReason;

  DropDownItem<String>? get selectedReason => _selectedReason;

  set selectedReason(DropDownItem<String>? value) {
    _selectedReason = value;
    notifyListeners();
  }
}
