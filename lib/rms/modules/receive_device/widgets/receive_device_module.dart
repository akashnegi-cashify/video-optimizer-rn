import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/rms/modules/facility_list/screens/facility_list_screen.dart';
import 'package:flutter_trc/rms/modules/receive_device/dialog/show_accessories_dialog.dart';
import 'package:flutter_trc/rms/modules/receive_device/providers/receive_device_module_provider.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/accessories_data.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/barcode_type_selection_dialog.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:provider/provider.dart';

import '../barcode_types.dart';
import '../l10n.dart';

class ReceiveDeviceModule extends StatelessWidget {
  final VoidCallback? onFacilityChanged;

  const ReceiveDeviceModule({this.onFacilityChanged, super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
        create: (_) => ReceiveDeviceModuleProvider(),
        builder: (innerContext, child) {
          var provider = ReceiveDeviceModuleProvider.of(innerContext, listen: false);
          return CshBigButton(
              text: l10n.receiveDevice, onPressed: () => _onReceiveDeviceButtonClicked(context, provider));
        });
  }

  _onReceiveDeviceButtonClicked(BuildContext context, ReceiveDeviceModuleProvider provider) {
    FacilityListData? facility = AppPreferences.app.getFacility();
    if (facility == null) {
      _getFacility(context, onSelected: () {
        onFacilityChanged?.call();
        _onProceed(context, provider);
      });
    } else {
      _onProceed(context, provider);
    }
  }

  _getFacility(BuildContext context, {required VoidCallback onSelected}) {
    FacilityListScreen.openFacilityScreen(context, onFacilitySelected: (facility) {
      Navigator.pop(context); // Close the facility list screen
      AppPreferences.app.setFacility(facility).then((_) {
        onSelected();
      });
    });
  }

  _onProceed(BuildContext context, ReceiveDeviceModuleProvider provider) {
    showBarcodeTypeSelectionDialog(
      context,
      onSelected: (barcodeType) {
        Navigator.pop(context); // Close the dialog
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            int facilityId = AppPreferences.app.getFacility()?.id ?? 0;
            CshLoading().showLoading(context);
            controller?.stop();
            provider.getDeviceDetails(scannedData, barcodeType).then((value) {
              CshLoading().hideLoading(context);
              if (value.isNotEmpty) {
                showAccessoriesDialog(context, value, onAccessoriesSelected: (accessoriesList) {
                  Navigator.pop(context); // Close the dialog
                  _receiveDevice(context, scannedData, barcodeType, facilityId, provider,
                      accessoriesList: accessoriesList);
                }).whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    controller?.start();
                  });
                });
              } else {
                _receiveDevice(context, scannedData, barcodeType, facilityId, provider);
              }
            }, onError: (error) {
              CshLoading().hideLoading(context);
              controller?.start();
              CshSnackBar.error(context: context, message: error.toString());
            });
          },
        );
      },
    );
  }

  _receiveDevice(BuildContext context, String barcode, BarcodeTypes barcodeType, int facilityId,
      ReceiveDeviceModuleProvider provider,
      {List<AccessoriesData>? accessoriesList}) {
    CshLoading().showLoading(context);
    provider.receiveDevice(barcode, barcodeType, facilityId, accessoriesList).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: value);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }
}
