import 'dart:convert';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/libraries/get_storage/csh_get_storage.dart';

enum _AppPreferencesKeys {
  loginType("loginType"),
  facility("facility");

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
    _util.setString(_AppPreferencesKeys.loginType.value, loginType);
  }

  Future<String?> getLoginType() async {
    return await _util.getString(_AppPreferencesKeys.loginType.value);
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

  resetAndClearAll() async {
    _util.clear();
    _cshGetStorageUtil.clear();
    await AuthHandler().onSessionExpire();
  }
}
