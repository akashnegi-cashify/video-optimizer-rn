import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/auto_search_button_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/device_verify_popup_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/manual_search_button_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/update_device_category_event.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n.dart';

class LobDeviceDetailWidget extends StatefulWidget {
  final String scannedData;
  final DeviceDetailResponseData? deviceDetails;
  final Function(bool isManual, int selectedCategoryId) onSearchClicked;

  const LobDeviceDetailWidget(
      {required this.scannedData, this.deviceDetails, required this.onSearchClicked, super.key});

  @override
  State<LobDeviceDetailWidget> createState() => _LobDeviceDetailWidgetState();
}

class _LobDeviceDetailWidgetState extends State<LobDeviceDetailWidget> {
  final List<DropDownItem> _categoryList = [];
  DropDownItem? _selectedCategory;
  bool _isImeiVerified = false;
  late bool _isRunImeiValidatorFlow;

  bool _isScannedSuccessfully = false;

  @override
  void initState() {
    _isRunImeiValidatorFlow = RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW);

    widget.deviceDetails?.categories?.forEach((key, value) {
      var dropDownItem = DropDownItem("$key", value);
      _categoryList.add(dropDownItem);

      /// check if selectedCategoryId exist in category list or not
      if (widget.deviceDetails?.selectedCategoryId == key && _selectedCategory == null) {
        _selectedCategory = dropDownItem;
      }
    });
    if (_selectedCategory?.id != "1") {
      _isImeiVerified = true;
    }
    AnalyticsController.logEvent(DeviceVerifyPopupEvent(widget.scannedData, _selectedCategory?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Container(
      padding: const EdgeInsets.all(Dimens.space_20),
      child: Column(
        children: [
          CshTextNew.subTitle1(l10n.updateCategoryIfNeeded),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.category}:", isPrimary: false)),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: CshDropDown(
                  items: _categoryList,
                  hintText: l10n.selectCategory,
                  selectedItem: _selectedCategory,
                  onChanged: (DropDownItem? value) {
                    AnalyticsController.logEvent(
                        UpdateDeviceCategoryEvent(widget.scannedData, _selectedCategory?.id, value?.id));
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.barcode}:", isPrimary: false)),
              Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.scannedData)),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.imei}:", isPrimary: false)),
              Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.deviceDetails?.imei1 ?? "NA")),
            ],
          ),
          if (!Validator.isNullOrEmpty(widget.deviceDetails?.imei2)) ...[
            const SizedBox(height: Dimens.space_16),
            Row(
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.imei2}:", isPrimary: false)),
                Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.deviceDetails?.imei2 ?? "NA")),
              ],
            ),
          ],
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.serialNo}:", isPrimary: false)),
              Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.deviceDetails?.serialNo ?? "NA")),
            ],
          ),
          if (_isRunImeiValidatorFlow &&
              _selectedCategory?.id == DeviceCategoryIdType.mobile.value &&
              !_isImeiVerified) ...[
            const SizedBox(height: Dimens.space_24),
            CshMediumButton(
                text: l10n.validateImei,
                onPressed: () {
                  _openImeiScanner();
                }),
          ],
          const SizedBox(height: Dimens.space_24),
          ComboButton(
            firstBtnText: l10n.manualSearch,
            padding: EdgeInsets.zero,
            secondBtnText: l10n.search,
            isFirstPrimary: true,
            buttonType: ButtonType.mini,
            firstBtnClick: _isSearchButtonEnabled()
                ? () {
                    AnalyticsController.logEvent(
                        ManualSearchButtonClickedEvent(widget.scannedData, _selectedCategory?.id));
                    widget.onSearchClicked(true, int.parse(_selectedCategory!.id!));
                  }
                : null,
            secondBtnClick: _isSearchButtonEnabled()
                ? () {
                    AnalyticsController.logEvent(
                        AutoSearchButtonClickedEvent(widget.scannedData, _selectedCategory?.id));
                    widget.onSearchClicked(false, int.parse(_selectedCategory!.id!));
                  }
                : null,
          )
        ],
      ),
    );
  }

  int getNeedToScannedValues() {
    if (widget.deviceDetails?.imei1 != null && widget.deviceDetails?.imei2 != null) {
      return 2;
    } else {
      return 1;
    }
  }

  _isSearchButtonEnabled() {
    if (_selectedCategory == null) {
      return false;
    }

    if (!_isRunImeiValidatorFlow) {
      return true;
    }

    return _selectedCategory!.id == DeviceCategoryIdType.mobile.value ? _isImeiVerified : true;
  }

  _isImeiMatched(List<String> scannedList) {
    if (scannedList.contains(widget.deviceDetails?.imei1)) {
      if (widget.deviceDetails?.imei2 != null) {
        if (scannedList.contains(widget.deviceDetails?.imei2)) {
          return true;
        } else {
          return false;
        }
      }
      return true;
    }

    return false;
  }

  void _showErrorDialog(List<String> scannedList) {
    String scannedImeiData = scannedList.reduce((value, element) => "$value, $element");
    var theme = Theme.of(context);
    var l10n = L10n(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: Container(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew.h3(l10n.imeiMismatched),
            const SizedBox(height: Dimens.space_16),
            // CshTextNew.subTitle1("Scanned IMEI(s) does not match with device IMEI(s)"),
            Text(
              l10n.imeiMismatchDescription,
              style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
            ),
            // CshTextNew.subTitle1("Please capture Image of IMEI to report mismatch"),
            const SizedBox(height: Dimens.space_16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.deviceImei, isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle1("${widget.deviceDetails?.imei1}, ${widget.deviceDetails?.imei2 ?? ""}"),
                ),
              ],
            ),
            const Divider(height: Dimens.space_8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(l10n.scannedImei, isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle1(scannedImeiData),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space_24),
            CshMediumOutlineButton(
              text: l10n.reScan,
              onPressed: () {
                Navigator.pop(context); // close dialog
                _openImeiScanner();
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: l10n.reportMismatch,
              onPressed: () {
                Navigator.pop(context); // close dialog
                _onReportMismatch(scannedList);
              },
            ),
          ],
        ),
      ),
    ).whenComplete(() => _isScannedSuccessfully = false);
  }

  void _openImeiScanner() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ImeiScanner(
          onProceed: (List<String>? scannedList) {
            if (!_isScannedSuccessfully && (scannedList?.length ?? 0) >= getNeedToScannedValues()) {
              _isScannedSuccessfully = true;
              Navigator.pop(context); // close Imei Scanner
              if (Validator.isListNullOrEmpty(scannedList)) {
                return;
              }
              if (_isImeiMatched(scannedList!)) {
                setState(() {
                  _isImeiVerified = true;
                });
              } else {
                _showErrorDialog(scannedList);
              }
            }
          },
        );
      },
    ));
  }

  _onReportMismatch(List<String> scannedList) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    ImagePicker platform = ImagePicker();
    platform.pickImage(source: ImageSource.camera, requestFullMetadata: false).then((value) async {
      if (value != null) {
        CshLoading().showLoading(context);
        provider.reportMismatch(value.path, scannedList).then((value) {
          CshLoading().hideLoading(context);
          CshSnackBar.success(context: context, message: "Mismatch reported successfully");
          Navigator.pop(context);
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error.toString());
        });
      }
    });
  }
}
