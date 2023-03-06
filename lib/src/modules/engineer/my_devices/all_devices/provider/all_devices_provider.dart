import 'package:core_widgets/core_widgets.dart';

import '../../../resources/engineer_api_service.dart';
import '../../../models/engineer_device_info.dart';
import '../models/mark_in_progress_response.dart';

class AllDevicesProvider extends CshChangeNotifier {
  EngineerDeviceInfo? _selectedDevice;

  EngineerDeviceInfo? get selectedDevice => _selectedDevice;

  set selectedDevice(EngineerDeviceInfo? value) {
    _selectedDevice = value;
    notifyListeners();
  }

  Stream<MarkInProgressResponse?> markDeviceInProgress() {
    assert(selectedDevice != null && selectedDevice!.deviceBarcode != null,
        "Device is not selected to mark for progress!");
    return EngineerAPIService.sendToInProgress(selectedDevice!.deviceBarcode!);
  }

}
