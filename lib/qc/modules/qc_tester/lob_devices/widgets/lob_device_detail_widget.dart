import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/select_category_bottom_sheet.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_manul_enter_serial_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_mismatch_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_mismatch_serial_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_timeout_reason_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_update_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/src/common/widgets/dropdown_view_widget.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/device_verify_popup_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/select_brand_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/update_device_category_event.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';

import '../dialogs/select_brand_bottom_sheet.dart';
import '../l10n.dart';

class LobDeviceDetailWidget extends StatefulWidget {
  final String scannedData;
  final DeviceDetailResponseData? deviceDetails;
  final Function(int brandId, int selectedCategoryId) onSearchClicked;

  const LobDeviceDetailWidget(
      {required this.scannedData, this.deviceDetails, required this.onSearchClicked, super.key});

  @override
  State<LobDeviceDetailWidget> createState() => _LobDeviceDetailWidgetState();
}

class _LobDeviceDetailWidgetState extends State<LobDeviceDetailWidget> {
  CategoryData? _selectedCategory;
  BrandListData? _selectedBrand;
  bool _isImeiVerified = false;
  bool _isSerialVerified = false;
  late bool _isRunImeiValidatorFlow = false;
  late bool _isRunSerialValidatorFlow = false;
  int _serialNoRetryCounter = 0;
  bool _isShowManualEnterSerialButton = false;

  @override
  void initState() {
    String? loginType = AppPreferences.app.getLoginType();
    if (loginType != null) {
      var loginTypeEnum = LoginTypes.fromValue(loginType);
      if (loginTypeEnum == LoginTypes.qcLogin) {
        _isRunImeiValidatorFlow = RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW);
        _isRunSerialValidatorFlow = RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW);
      }
    }

    /// check if selectedCategoryId exist in category list or not
    if (widget.deviceDetails?.selectedCategoryId != null) {
      var index = widget.deviceDetails?.categoryList
          ?.indexWhere((element) => element.id == widget.deviceDetails?.selectedCategoryId);
      if (index != null && index > -1) {
        _selectedCategory = widget.deviceDetails?.categoryList?[index];
        var provider = LobDeviceScannerProvider.of(context, listen: false);
        provider.getBrandList(_selectedCategory!.id!).whenComplete(() {
          _selectedBrand = provider.selectedBrand;
        });
      }
    }

    if (_selectedCategory?.categoryKey != DeviceCategoryIdType.mobile.value) {
      _isImeiVerified = true;
    }

    if (_selectedCategory?.categoryKey != DeviceCategoryIdType.laptop.value) {
      _isSerialVerified = true;
    }

    AnalyticsController.logEvent(DeviceVerifyPopupEvent(widget.scannedData, _selectedCategory?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = LobDeviceScannerProvider.of(context, listen: false);
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
                child: DropdownViewWidget(
                  value: _selectedCategory?.name ?? l10n.selectCategory,
                  isDataSelected: _selectedCategory != null,
                  onPressed: () {
                    selectCategoryBottomSheet(
                      context,
                      widget.deviceDetails?.categoryList,
                      onCategorySelected: (category) {
                        Navigator.pop(context); // close bottom sheet
                        AnalyticsController.logEvent(
                            UpdateDeviceCategoryEvent(widget.scannedData, _selectedCategory?.id, category.id));
                        _selectedBrand = null;
                        provider.getBrandList(category.id!).whenComplete(
                          () {
                            setState(() {
                              _selectedCategory = category;
                              _selectedBrand = provider.selectedBrand;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          if (_selectedCategory != null && !Validator.isListNullOrEmpty(provider.brandList)) ...[
            const SizedBox(height: Dimens.space_16),
            Row(
              children: [
                Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.brand}:", isPrimary: false)),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: DropdownViewWidget(
                    value: _selectedBrand?.brandName ?? l10n.selectBrand,
                    isDataSelected: _selectedBrand != null,
                    onPressed: () {
                      selectBrandBottomSheet(
                        context,
                        provider.brandList ?? [],
                        onBrandSelect: (brand) {
                          Navigator.pop(context);
                          AnalyticsController.logEvent(SelectBrandEvent(widget.scannedData, brand.brandId.toString()));
                          setState(() {
                            _selectedBrand = brand;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
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
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.imei2}:", isPrimary: false)),
              Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.deviceDetails?.imei2 ?? "NA")),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("${l10n.serialNo}:", isPrimary: false)),
              Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(widget.deviceDetails?.serialNo ?? "NA")),
            ],
          ),
          if (_isRunImeiValidatorFlow && _selectedCategory?.categoryKey == DeviceCategoryIdType.mobile.value) ...[
            const SizedBox(height: Dimens.space_24),
            CshMediumButton(
              text: l10n.validateImei,
              onPressed: !_isImeiVerified ? () => _openSerialImeiScanner() : null,
            ),
          ],
          if (_isRunSerialValidatorFlow && _selectedCategory?.categoryKey == DeviceCategoryIdType.laptop.value) ...[
            const SizedBox(height: Dimens.space_24),
            CshMediumButton(
              text: l10n.validateSerial,
              onPressed:
                  !_isSerialVerified ? () => _openSerialImeiScanner(readerType: ReaderType.serialNumberReader) : null,
            ),
          ],
          if (_isShowManualEnterSerialButton &&
              _selectedCategory?.categoryKey == DeviceCategoryIdType.laptop.value) ...[
            const SizedBox(height: Dimens.space_24),
            CshMediumButton(
                text: l10n.enterSerialManually,
                width: const ButtonWidth(minWidth: 150, maxWidth: 300),
                onPressed: () {
                  showManualEnterSerialNo(
                    context,
                    subTitle: "Need an Image for approval",
                    onSerialNoEntered: (serialNo) {
                      Navigator.pop(context); // close dialog
                      if (widget.deviceDetails?.isDeviceImeiApproved == true &&
                          widget.deviceDetails?.serialNo == serialNo) {
                        setState(() {
                          _isSerialVerified = true;
                        });
                      } else {
                        _onReportMismatch([serialNo],
                            isImei2Available: false,
                            isSerialNo: true,
                            onComplete: () => Navigator.pop(context)); // move to previous screen,
                      }
                    },
                  );
                }),
          ],
          const SizedBox(height: Dimens.space_24),
          CshMediumButton(
            text: l10n.search,
            onPressed: _isSearchButtonEnabled()
                ? () => widget.onSearchClicked(_selectedBrand!.brandId!, _selectedCategory!.id!)
                : null,
          ),
        ],
      ),
    );
  }

  int _getNeedToScannedValues() {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    if (provider.timeoutSelectedReason != null) {
      return 1;
    }
    if (widget.deviceDetails?.imei1 != null && widget.deviceDetails?.imei2 != null) {
      return 2;
    } else {
      return 1;
    }
  }

  _isSearchButtonEnabled() {
    if (_selectedCategory == null || _selectedBrand == null) {
      return false;
    }

    if (_selectedCategory!.categoryKey == DeviceCategoryIdType.mobile.value) {
      return _isImeiVerificationCompleted();
    } else if (_selectedCategory!.categoryKey == DeviceCategoryIdType.laptop.value) {
      return _isSerialNoVerificationCompleted();
    } else {
      return true;
    }
  }

  bool _isImeiVerificationCompleted() {
    if (_isRunImeiValidatorFlow) {
      return _isImeiVerified;
    } else {
      return true;
    }
  }

  bool _isSerialNoVerificationCompleted() {
    if (_isRunSerialValidatorFlow) {
      return _isSerialVerified;
    } else {
      return true;
    }
  }

  _isImeiMatched(List<String> scannedList) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    if (provider.timeoutSelectedReason != null) {
      return scannedList.contains(widget.deviceDetails?.imei1) || scannedList.contains(widget.deviceDetails?.imei2);
    }

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

  String? _getMatchedImei(List<String>? scannedList) {
    if (scannedList == null) {
      return null;
    }

    if (scannedList.contains(widget.deviceDetails?.imei1)) {
      return widget.deviceDetails?.imei1;
    }

    if (widget.deviceDetails?.imei2 != null && scannedList.contains(widget.deviceDetails?.imei2)) {
      return widget.deviceDetails?.imei2;
    }

    return null;
  }

  void _openSerialImeiScanner({bool isResetTimeoutReasons = true, ReaderType readerType = ReaderType.imeiReader}) {
    if (isResetTimeoutReasons) {
      var provider = LobDeviceScannerProvider.of(context, listen: false);
      provider.updateReason(null);
    }

    /// Reset this flag when open Imei Scanner
    bool isBusy = false;

    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ImeiScanner(
          config: ParserConfig(readerType: readerType),
          onProceed: (List<String>? scannedList) {
            if (!isBusy) {
              isBusy = true;
              if (readerType == ReaderType.imeiReader) {
                _onImeiScannedResults(scannedList, () {
                  isBusy = false;
                });
              } else {
                Navigator.pop(context); // close Imei Scanner
                _onSerialScannedResults(scannedList);
              }
            }
          },
          onTimeOut: () => _onScanningTimeout(readerType),
        );
      },
    ));
  }

  _onScanningTimeout(ReaderType readerType) {
    Navigator.pop(context); // close Imei Scanner
    if (readerType == ReaderType.serialNumberReader) {
      if (_serialNoRetryCounter >= 2) {
        setState(() {
          _isShowManualEnterSerialButton = true;
        });
        return;
      } else {
        _serialNoRetryCounter++;
      }
    }

    var provider = LobDeviceScannerProvider.of(context, listen: false);
    if (!Validator.isListNullOrEmpty(provider.timeoutReasons)) {
      showTimeOutReasonDialog(context, provider.timeoutReasons, onReasonSelected: (reason) {
        Navigator.pop(context); // close Timeout dialog
        provider.updateReason(reason);
        _openSerialImeiScanner(isResetTimeoutReasons: false, readerType: readerType);
      });
    } else {
      CshSnackBar.error(
        context: context,
        message: "Not able to scan ${readerType == ReaderType.imeiReader ? "IMEI" : "Serial No"}",
      );
    }
  }

  _onImeiScannedResults(List<String>? scannedList, VoidCallback resetBusyFlag) {
    /// When only 1 IMEI is available and scanned IMEI List is also 1 and IMEI is already approved
    if (_is1ImeiAvailable() && scannedList?.length == 1) {
      String? matchedImei = _getMatchedImei(scannedList);

      /// If IMEI is matched and IMEI is already approved
      if (!Validator.isNullOrEmpty(matchedImei) && Validator.isTrue(widget.deviceDetails?.isDeviceImeiApproved)) {
        Navigator.pop(context); // close Imei Scanner
        setState(() {
          _isImeiVerified = true;
        });
        return;
      } else {
        resetBusyFlag();
      }
    }

    /// When only 1 IMEI is available and scanned IMEI is matched
    if (_is1ImeiAvailable()) {
      String? matchedImei = _getMatchedImei(scannedList);

      /// If IMEI is matched
      if (!Validator.isNullOrEmpty(matchedImei)) {
        Navigator.pop(context); // close Imei Scanner
        showUpdateImeiDialog(
          context,
          scannedList!,
          matchedImei,
          onRescan: () {
            _openSerialImeiScanner(isResetTimeoutReasons: false);
          },
          onUpdateImei: (updatedImei, isImeiAvailable, filePath, isAutoApproved) {
            _onImeiUpdate(updatedImei, isImeiAvailable, filePath, isAutoApproved);
          },
        );
        return;
      } else {
        resetBusyFlag();
      }
    }

    /// When scanned IMEI List has logic acc to timeout and how many IMEI is available
    if ((scannedList?.length ?? 0) >= _getNeedToScannedValues()) {
      Navigator.pop(context); // close Imei Scanner
      if (_isImeiMatched(scannedList!)) {
        setState(() {
          _isImeiVerified = true;
        });
        var provider = LobDeviceScannerProvider.of(context, listen: false);
        if (provider.timeoutSelectedReason != null) {
          CshSnackBar.show(
            context: context,
            message: "Please capture an image",
            duration: SnackBarDuration.MEDIUM,
          );
          _onReportMismatch(scannedList);
        }
      } else {
        showMismatchImeiDialog(
          context,
          scannedList,
          imei1: widget.deviceDetails?.imei1,
          imei2: widget.deviceDetails?.imei2,
          onReScan: () {
            _openSerialImeiScanner(isResetTimeoutReasons: false);
          },
          onReportMismatch: (scannedList, isImei2Available) {
            _onReportMismatch(scannedList,
                isImei2Available: isImei2Available,
                onComplete: () => Navigator.pop(context)); // move to previous screen,
          },
        );
      }
    }
  }

  _is1ImeiAvailable() {
    if (!Validator.isNullOrEmpty(widget.deviceDetails?.imei1) && Validator.isNullOrEmpty(widget.deviceDetails?.imei2)) {
      return true;
    }
    return false;
  }

  _onReportMismatch(List<String> scannedList,
      {bool? isImei2Available, VoidCallback? onComplete, bool isSerialNo = false}) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    ImagePicker platform = ImagePicker();
    platform.pickImage(source: ImageSource.camera, requestFullMetadata: false).then((value) async {
      if (value != null) {
        CshLoading().showLoading(context);
        provider
            .reportMismatch(value.path, scannedList, isImei2Available: isImei2Available, isSerialNo: isSerialNo)
            .then((value) {
          CshLoading().hideLoading(context);
          CshSnackBar.success(context: context, message: "Mismatch reported successfully");
          if (onComplete != null) {
            onComplete();
          }
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error.toString());
        });
      }
    });
  }

  _onImeiUpdate(String? updatedImei, bool? isImeiAvailable, String filePath, bool isAutoApproved) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updateImei(filePath, updatedImei, isImeiAvailable, isAutoApproved: isAutoApproved).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "IMEI updated successfully");
      if (isAutoApproved) {
        setState(() {
          _isImeiVerified = true;
        });
      } else {
        Navigator.pop(context); // move to previous screen
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }

  _isSerialMatched(String? scannedSerialNo) {
    return widget.deviceDetails?.serialNo?.toLowerCase() == scannedSerialNo?.toLowerCase();
  }

  void _onSerialScannedResults(List<String>? scannedList) {
    if (_isSerialMatched(scannedList?.first)) {
      setState(() {
        _isSerialVerified = true;
      });
    } else {
      showMismatchSerialDialog(
        context,
        scannedList!.first,
        systemSerialNo: widget.deviceDetails!.serialNo!,
        onReScan: () {
          Navigator.pop(context); // close dialog
          _openSerialImeiScanner(isResetTimeoutReasons: false, readerType: ReaderType.serialNumberReader);
        },
        onReportMismatch: (scannedSerialNo, systemSerialNo) {
          Navigator.pop(context); // close dialog
          _onReportMismatch([scannedSerialNo],
              isSerialNo: true,
              isImei2Available: false,
              onComplete: () => Navigator.pop(context)); // move to previous screen,
        },
      );
    }
  }
}
