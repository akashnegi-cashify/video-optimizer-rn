import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_new_response.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class LotTypeFilterService {
  static Stream<LotTypeFilterResponse?> storeOutLotTypeFilters() {
    return QcService().get(
      "/store-out/v2/list-lot-types",
      LotTypeFilterResponse.fromJson,
    );
  }

  static Stream<LotTypeFilterNewResponse?> storeOutLotTypeFiltersNew() {
    return QcService().get(
      "/v1/lot/type",
      LotTypeFilterNewResponse.fromJson,
    );
  }
}
