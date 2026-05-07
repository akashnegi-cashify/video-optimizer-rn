import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/libraries/get_storage/base_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

enum _RmsPreferencesKeys {
  facility("facility");

  final String value;

  const _RmsPreferencesKeys(this.value);
}

class RmsStorage extends BaseStorage {
  RmsStorage() : super(StorageType.rmsStorage);

  Future<void> setFacility(FacilityListData facility) {
    return setString(_RmsPreferencesKeys.facility.value, jsonEncode(facility));
  }

  FacilityListData? getFacility() {
    FacilityListData? facility;
    String? value = getString(_RmsPreferencesKeys.facility.value);
    if (!Validator.isNullOrEmpty(value)) {
      facility = FacilityListData.fromJson(jsonDecode(value!));
    }
    return facility;
  }
}
