import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_service.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/utils/dotted_divider_line.dart';

import '../l10n.dart';
import '../resources/device_detail_response.dart';

class DeviceDetailsWidget extends StatefulWidget {
  final String deviceBarcode;

  const DeviceDetailsWidget(this.deviceBarcode, {super.key});

  @override
  State<DeviceDetailsWidget> createState() => _DeviceDetailsWidgetState();
}

class _DeviceDetailsWidgetState extends State<DeviceDetailsWidget> {
  late String _deviceBarcode;

  @override
  void initState() {
    _deviceBarcode = widget.deviceBarcode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return StreamBuilder(
      stream: DeviceDetailService.getDeviceDetails(_deviceBarcode),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CshShimmer();
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ApiErrorHelper.getErrorMessage(snapshot.error) ?? 'Something went wrong',
                  style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                ),
                const SizedBox(height: Dimens.space_16),
                CshMediumButton(
                    text: l10n.retry,
                    onPressed: () {
                      _onDeviceScanned();
                    }),
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          var data = snapshot.data;
          List<Widget> list = _getWidgetList(data!, theme, l10n);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CshCard(
                  padding: EdgeInsets.all(Dimens.space_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(data.modelName ?? "", style: theme.primaryTextTheme.headlineMedium)),
                          _column(l10n.barcode, data.barcode ?? "", theme),
                        ],
                      ),
                      SizedBox(height: Dimens.space_8),
                      DottedLineDivider(dashWidth: Dimens.space_4),
                      SizedBox(height: Dimens.space_8),
                      ...list,
                      FutureBuilder(
                        future: _getStockMovement(_deviceBarcode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Stepper(steps: snapshot.data!);
                            }
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.space_16),
                CshMediumButton(
                    text: l10n.scanOtherDevice,
                    onPressed: () {
                      _onDeviceScanned();
                    }),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<Widget> _getWidgetList(DeviceDetailResponse detail, ThemeData theme, L10n l10n) {
    List<Widget> widgetList = [];
    if (!Validator.isNullOrEmpty(detail.imei)) {
      widgetList.add(_column(l10n.imei1, detail.imei!, theme));
    }
    if (!Validator.isNullOrEmpty(detail.imei2)) {
      widgetList.add(_column(l10n.imei2, detail.imei2!, theme));
    }
    if (!Validator.isNullOrEmpty(detail.serialNo)) {
      widgetList.add(_column(l10n.serialNo, detail.serialNo!, theme));
    }
    if (!Validator.isNullOrEmpty(detail.location)) {
      widgetList.add(_column(l10n.location, detail.location!, theme));
    }
    if (!Validator.isNullOrEmpty(detail.status)) {
      widgetList.add(_column(l10n.currentStatus, detail.status!, theme));
    }
    if (!Validator.isNullOrEmpty(detail.repairStatus)) {
      widgetList.add(_column(l10n.repairStatus, detail.repairStatus!, theme));
    }
    if (!Validator.isListNullOrEmpty(detail.channelList)) {
      widgetList.add(_column(l10n.channelName, detail.channelList!.join(" | "), theme));
    }
    if (detail.stockAge != null) {
      widgetList.add(_column(l10n.stockAge, detail.stockAge.toString(), theme));
    }
    if (!Validator.isNullOrEmpty(detail.lotName)) {
      widgetList.add(_column(l10n.lotName, detail.lotName.toString(), theme));
    }
    if (!Validator.isNullOrEmpty(detail.otexSource)) {
      widgetList.add(_column(l10n.otexSource, detail.otexSource.toString(), theme));
    }

    List<Widget> formatedList = [];
    for (var i = 0; i < widgetList.length; i += 2) {
      if (i > widgetList.length) {
        break;
      }
      if ((i + 1) < widgetList.length) {
        formatedList.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
          child: Row(
            children: [
              Flexible(flex: 3, fit: FlexFit.tight, child: widgetList[i]),
              Flexible(flex: 1, fit: FlexFit.tight, child: widgetList[i + 1]),
            ],
          ),
        ));
      } else {
        formatedList.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
          child: widgetList[i],
        ));
      }
    }
    return formatedList;
  }

  _onDeviceScanned() {
    CshMlScannerUtil().openScanner(
      context,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // close scanner
        setState(() {
          _deviceBarcode = scannedData;
        });
      },
    );
  }

  _column(String title, String value, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.bodySmall),
        Text(value, style: theme.primaryTextTheme.headlineMedium),
      ],
    );
  }

  Future<List<Step>> _getStockMovement(String deviceBarcode) {
    var completer = Completer<List<Step>>();
    DeviceDetailService.getDeviceStockMovement(deviceBarcode).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.stockMovementList)) {
        List<Step> stepperList = event!.stockMovementList!.map((e) {
          return Step(
            title: CshTextNew.subTitle1(e.status ?? ""),
            subtitle: CshTextNew.bodyText2(e.createdBy ?? ""),
            content: CshTextNew.bodyText2(e.createdBy ?? ""),
            isActive: e.isCurrentStatus ?? false,
          );
        }).toList();
        completer.complete(stepperList);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
