import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/rms/modules/facility_list/screens/facility_list_screen.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/receive_device_service.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/barcode_type_selection_dialog.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';

import '../l10n.dart';

class ReceiveDeviceModule extends StatelessWidget {
  final VoidCallback? onFacilityChanged;

  const ReceiveDeviceModule({this.onFacilityChanged, super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return CshBigButton(text: l10n.receiveDevice, onPressed: () => _onReceiveDeviceButtonClicked(context));
  }

  _onReceiveDeviceButtonClicked(BuildContext context) {
    FacilityListData? facility = AppPreferences.app.getFacility();
    if (facility == null) {
      FacilityListScreen.openFacilityScreen(context, onFacilitySelected: (facility) {
        Navigator.pop(context); // Close the facility list screen
        AppPreferences.app.setFacility(facility).then((_) {
          onFacilityChanged?.call();
          _onProceed(context);
        });
      });
    } else {
      _onProceed(context);
    }
  }

  _onProceed(BuildContext context) {
    showBarcodeTypeSelectionDialog(
      context,
      onSelected: (barcodeType) {
        Navigator.pop(context); // Close the dialog
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            CshLoading().showLoading(context);
            int facilityId = AppPreferences.app.getFacility()?.id ?? 0;
            ReceiveDeviceService.receiveDevice(scannedData, facilityId, barcodeType).listen((event) {
              CshLoading().hideLoading(context);
              Navigator.pop(context); // Close the scanner
              CshSnackBar.success(context: context, message: event?.successMessage ?? "Device received successfully");
            }, onError: (error) {
              CshLoading().hideLoading(context);
              String? errorMessage = ApiErrorHelper.getErrorMessage(error);
              CshSnackBar.error(context: context, message: errorMessage.toString());
            });
          },
        );
      },
    );
  }
}
