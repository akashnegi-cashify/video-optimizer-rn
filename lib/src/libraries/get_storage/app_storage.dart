import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/libraries/get_storage/base_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

enum _AppPreferencesKeys {
  loginType("loginType"),
  facility("facility");

  final String value;

  const _AppPreferencesKeys(this.value);
}

class AppStorage extends BaseStorage {
  AppStorage() : super(StorageType.appStorage);

  Future<void> setLoginType(String loginType) {
    return setString(_AppPreferencesKeys.loginType.value, loginType);
  }

  String? getLoginType() {
    return getString(_AppPreferencesKeys.loginType.value);
  }

  Future<void> setFacility(FacilityListData facility) {
    return setString(_AppPreferencesKeys.facility.value, jsonEncode(facility));
  }

  FacilityListData? getFacility() {
    FacilityListData? facility;
    String? value = getString(_AppPreferencesKeys.facility.value);
    if (!Validator.isNullOrEmpty(value)) {
      facility = FacilityListData.fromJson(jsonDecode(value!));
    }
    return facility;
  }
}
