import 'package:core_widgets/core_widgets.dart';

class ReturnPartProvider extends CshChangeNotifier {
  DropDownItem<String>? _selectedReason;
  String? _retrievedPartBarcode;
  String? remarks;

  String? get retrievedPartBarcode => _retrievedPartBarcode;

  set retrievedPartBarcode(String? value) {
    _retrievedPartBarcode = value;
    notifyListeners();
  }

  DropDownItem<String>? get selectedReason => _selectedReason;

  set selectedReason(DropDownItem<String>? value) {
    _selectedReason = value;
    notifyListeners();
  }

  bool isEnabled(bool isRetrievedPartAssign) {
    if (selectedReason == null) {
      return false;
    }

    if (isRetrievedPartAssign && Validator.isNullOrEmpty(retrievedPartBarcode)) {
      return false;
    }

    return true;
  }
}
