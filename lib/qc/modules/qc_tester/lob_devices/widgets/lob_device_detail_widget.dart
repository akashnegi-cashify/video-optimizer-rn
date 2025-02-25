import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/select_category_bottom_sheet.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_mismatch_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_update_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/reasons.dart';
import 'package:flutter_trc/src/common/widgets/dropdown_view_widget.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/device_verify_popup_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/manual_search_button_clicked_event.dart';
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
  late bool _isRunImeiValidatorFlow = false;

  bool _isScannedSuccessfully = false;

  @override
  void initState() {
    String? loginType = AppPreferences.app.getLoginType();
    if (loginType != null) {
      var loginTypeEnum = LoginTypes.fromValue(loginType);
      setState(() {
        _isRunImeiValidatorFlow = loginTypeEnum == LoginTypes.qcLogin
            ? RemoteConfigHelper().getBoolean(AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW)
            : false;
      });
    }

    /// check if selectedCategoryId exist in category list or not
    if (widget.deviceDetails?.selectedCategoryId != null) {
      var index = widget.deviceDetails?.categoryList
          ?.indexWhere((element) => element.id == widget.deviceDetails?.selectedCategoryId);
      if (index != null && index > -1) {
        _selectedCategory = widget.deviceDetails?.categoryList?[index];
      }
    }

    if (_selectedCategory?.id != DeviceCategoryIdType.mobile.value) {
      _isImeiVerified = true;
    }

    if (_selectedCategory != null) {
      var provider = LobDeviceScannerProvider.of(context, listen: false);
      provider.getBrandList(_selectedCategory!.id!).whenComplete(() {
        _selectedBrand = provider.selectedBrand;
      });
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
          CshMediumButton(
            text: l10n.search,
            onPressed: _isSearchButtonEnabled()
                ? () {
                    // AnalyticsController.logEvent(
                    //     AutoSearchButtonClickedEvent(widget.scannedData, _selectedCategory?.id));
                    AnalyticsController.logEvent(
                        ManualSearchButtonClickedEvent(widget.scannedData, _selectedCategory?.id));
                    widget.onSearchClicked(_selectedBrand!.brandId!, _selectedCategory!.id!);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  int getNeedToScannedValues() {
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
    if (_selectedCategory == null) {
      return false;
    }

    if (_selectedBrand == null) {
      return false;
    }

    if (!_isRunImeiValidatorFlow) {
      return true;
    }

    return _selectedCategory!.id == DeviceCategoryIdType.mobile.value ? _isImeiVerified : true;
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

  void _openImeiScanner({bool isResetTimeoutReasons = true}) {
    if (isResetTimeoutReasons) {
      var provider = LobDeviceScannerProvider.of(context, listen: false);
      provider.updateReason(null);
    }

    /// Reset this flag when open Imei Scanner
    _isScannedSuccessfully = false;

    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ImeiScanner(
          config: ParserConfig(readerType: ReaderType.imeiReader),
          onProceed: (List<String>? scannedList) {
            /// When only 1 IMEI is available and scanned IMEI List is also 1 and IMEI is already approved
            if (!_isScannedSuccessfully && _is1ImeiAvailable() && scannedList?.length == 1) {
              _isScannedSuccessfully = true;
              String? matchedImei = _getMatchedImei(scannedList);

              /// If IMEI is matched and IMEI is already approved
              if (!Validator.isNullOrEmpty(matchedImei) &&
                  Validator.isTrue(widget.deviceDetails?.isDeviceImeiApproved)) {
                Navigator.pop(context); // close Imei Scanner
                setState(() {
                  _isImeiVerified = true;
                });
                return;
              } else {
                _isScannedSuccessfully = false;
              }
            }

            /// When only 1 IMEI is available and scanned IMEI is matched
            if (!_isScannedSuccessfully && _is1ImeiAvailable()) {
              _isScannedSuccessfully = true;
              String? matchedImei = _getMatchedImei(scannedList);

              /// If IMEI is matched
              if (!Validator.isNullOrEmpty(matchedImei)) {
                Navigator.pop(context); // close Imei Scanner
                showUpdateImeiDialog(
                  context,
                  scannedList!,
                  matchedImei,
                  onRescan: () {
                    _openImeiScanner(isResetTimeoutReasons: false);
                  },
                  onUpdateImei: (updatedImei, isImeiAvailable, filePath, isAutoApproved) {
                    _onImeiUpdate(updatedImei, isImeiAvailable, filePath, isAutoApproved);
                  },
                );
                return;
              } else {
                _isScannedSuccessfully = false;
              }
            }

            /// When scanned IMEI List has logic acc to timeout and how many IMEI is available
            if (!_isScannedSuccessfully && (scannedList?.length ?? 0) >= getNeedToScannedValues()) {
              _isScannedSuccessfully = true;
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
                    _openImeiScanner(isResetTimeoutReasons: false);
                  },
                  onReportMismatch: (scannedList, isImei2Available) {
                    _onReportMismatch(scannedList,
                        isImei2Available: isImei2Available,
                        onComplete: () => Navigator.pop(context)); // move to previous screen,
                  },
                );
              }
            }
          },
          onTimeOut: () {
            var provider = LobDeviceScannerProvider.of(context, listen: false);
            if (!Validator.isListNullOrEmpty(provider.timeoutReasons)) {
              Navigator.pop(context); // close Imei Scanner
              _showTimeoutReasons(
                provider.timeoutReasons,
                onReasonSelected: (reason) {
                  Navigator.pop(context); // close Timeout dialog
                  provider.updateReason(reason);
                  _openImeiScanner(isResetTimeoutReasons: false);
                },
              );
            } else {
              CshSnackBar.error(context: context, message: "Not able to scan IMEI");
            }
          },
        );
      },
    ));
  }

  _is1ImeiAvailable() {
    if (!Validator.isNullOrEmpty(widget.deviceDetails?.imei1) && Validator.isNullOrEmpty(widget.deviceDetails?.imei2)) {
      return true;
    }
    return false;
  }

  _showTimeoutReasons(List<Reasons> reasons, {required Function(Reasons reason) onReasonSelected}) {
    var l10n = L10n(context, listen: false);
    showCshBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew.h3(l10n.unableToScan),
            const SizedBox(height: Dimens.space_16),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = reasons[index];
                  return GestureDetector(
                    onTap: () => onReasonSelected(item),
                    child: CshCard(child: CshTextNew.subTitle1(item.name ?? "NA")),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: Dimens.space_8);
                },
                itemCount: reasons.length),
          ],
        ),
      ),
    );
  }

  _onReportMismatch(List<String> scannedList, {bool? isImei2Available, VoidCallback? onComplete}) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    ImagePicker platform = ImagePicker();
    platform.pickImage(source: ImageSource.camera, requestFullMetadata: false).then((value) async {
      if (value != null) {
        CshLoading().showLoading(context);
        provider.reportMismatch(value.path, scannedList, isImei2Available: isImei2Available).then((value) {
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
}
