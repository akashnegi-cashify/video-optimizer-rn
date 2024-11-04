import 'dart:convert';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/libraries/get_storage/csh_get_storage.dart';

enum _AppPreferencesKeys {
  loginType("loginType"),
  facility("facility"),
  qcPin("qcPin"),
  qcBiometrics("qcBiometrics");

  final String value;

  const _AppPreferencesKeys(this.value);
}

class AppPreferences {
  late final SharedPreferencesUtil _util;
  late final CshGetStorageUtil _cshGetStorageUtil;

  AppPreferences._privateConstructor() {
    _cshGetStorageUtil = CshGetStorageUtil();
    _util = SharedPreferencesUtil();
  }

  static final AppPreferences _instance = AppPreferences._privateConstructor();

  factory AppPreferences() {
    return _instance;
  }

  Future<bool> init() {
    return _cshGetStorageUtil.init();
  }

  setLoginType(String loginType) {
    _cshGetStorageUtil.setString(_AppPreferencesKeys.loginType.value, loginType);
  }

  String? getLoginType() {
    return _cshGetStorageUtil.getString(_AppPreferencesKeys.loginType.value);
  }

  Future<void> setFacility(FacilityListData facility) {
    return _cshGetStorageUtil.setString(_AppPreferencesKeys.facility.value, jsonEncode(facility));
  }

  FacilityListData? getFacility() {
    FacilityListData? facility;
    String? value = _cshGetStorageUtil.getString(_AppPreferencesKeys.facility.value);
    if (!Validator.isNullOrEmpty(value)) {
      facility = FacilityListData.fromJson(jsonDecode(value!));
    }
    return facility;
  }

  Future<void> setQcMPin(String mPin) {
    return _cshGetStorageUtil.setString(_AppPreferencesKeys.qcPin.value, mPin);
  }

  String? getQcMPin() {
    return _cshGetStorageUtil.getString(_AppPreferencesKeys.qcPin.value);
  }

  Future<void> setIsBioMetricEnabled(bool isBioMetricEnabled) {
    return _cshGetStorageUtil.setBool(_AppPreferencesKeys.qcBiometrics.value, isBioMetricEnabled);
  }

  bool? getIsBioMetricEnabled() {
    return _cshGetStorageUtil.getBool(_AppPreferencesKeys.qcBiometrics.value);
  }

  resetAndClearAll() async {
    _util.clear();
    _cshGetStorageUtil.clear();
    await AuthHandler().onSessionExpire();
  }
}
