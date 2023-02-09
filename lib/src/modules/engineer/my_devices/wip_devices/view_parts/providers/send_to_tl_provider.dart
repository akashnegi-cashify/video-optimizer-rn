import 'package:core_widgets/core_widgets.dart';

class SendToTLProvider extends CshChangeNotifier {

  DropDownItem? _selectedReason;

  DropDownItem? get selectedReason => _selectedReason;

  set selectedReason(DropDownItem? value) {
    _selectedReason = value;
    notifyListeners();
  }
}