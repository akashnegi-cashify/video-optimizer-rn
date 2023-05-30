import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/loading_dialog_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constants.dart';
import '../../../models/engineer_device_info.dart';
import '../../wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import '../provider/all_devices_provider.dart';
import 'all_devices_widget.dart';

class ItemAllDevicesWidget extends StatelessWidget {
  final EngineerDeviceInfo _deviceInfo;

  const ItemAllDevicesWidget(this._deviceInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    L10n l10n = L10n(context);

    AllDevicesProvider reader = AllDevicesProvider.of(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AssignedPartsScreen.route, arguments: AssignedPartsData(false, _deviceInfo));
      },
      child: CshCard(
          child: Row(
        children: [
          if (_deviceInfo.status != "In Progress")
            CshCheckbox(
              isSelected: Provider.of<AllDevicesProvider>(context, listen: true).selectedDevice == _deviceInfo,
              onChanged: (isChecked) {
                if (isChecked == true) {
                  reader.selectedDevice = _deviceInfo;
                  showCshBottomSheet(
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_32),
                      child: Align(
                        alignment: Alignment.center,
                        child: CshBigOutlineButton(
                          text: l10n.sendToInProgress,
                          onPressed: () {
                            CshLoading().showLoading(context);

                            reader.markDeviceInProgress().listen((event) {
                              // if response is null display error
                              if (event == null) {
                                CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
                                return;
                              }

                              // if backend sends any error message
                              if (event.errorMsg != null) {
                                CshSnackBar.error(context: context, message: event.errorMsg!);
                                return;
                              }

                              // if it's a success response
                              if (event.isSuccess) {
                                CshSnackBar.success(context: context, message: l10n.deviceSentToInProgress);
                                return;
                              }
                            }, onError: (error) {
                              // Display common API errors
                              CshSnackBar.error(
                                  context: context,
                                  message: ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
                            }, onDone: () {
                              // hide loading

                              if (reader.refreshAllDeviceList != null) {
                                reader.refreshAllDeviceList!();
                              }
                              CshLoading().hideLoading(context);
                              // popping of bottom sheet after the request completion
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ).whenComplete(() {
                    // on bottom sheet closing, set selected device to null
                    Provider.of<AllDevicesProvider>(context, listen: false).selectedDevice = null;
                  });
                } else {
                  // set selected device to null, if isChecked is false or null
                  Provider.of<AllDevicesProvider>(context, listen: false).selectedDevice = null;
                }
              },
            )
          else
            const SizedBox(
              height: Dimens.space_36,
            ),
          const Spacer(),
          SizedBox(
            width: width * 0.2,
            child: CshTextNew.h5(_deviceInfo.deviceBarcode ?? ""),
          ),
          const SizedBox(width: Dimens.space_8),
          SizedBox(
            width: width * 0.2,
            child: CshTextNew.h6(_deviceInfo.productTitle ?? ""),
          ),
          const Spacer(),
          SizedBox(
            width: width * 0.2,
            child: CshTextNew.h6(_deviceInfo.status ?? ""),
          ),
        ],
      )),
    );
  }
}
