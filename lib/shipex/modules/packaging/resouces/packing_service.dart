import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/shipex/shipex_service.dart';

import '../models/group_list_repsonse_data_model.dart';

class PackingService {
  static Stream<GroupListResponseModel?> getGroupNewDataList(int pageNumber, {String? query}) {
    Map<String, List<String>> queryParam = {
      "os": [pageNumber.toString()],
      "ps": ["10"],
      "gn": !Validator.isNullOrEmpty(query) ? [query!] : [""]
    };

    return ShipexService().get("/app/packaging/group/list", GroupListResponseModel.fromJson, params: queryParam);
  }

  static Stream<GroupListResponseModel?> getGroupPendingDataList() {
    return ShipexService().get("/app/packaging/group/list/in-process", GroupListResponseModel.fromJson);
  }
}
