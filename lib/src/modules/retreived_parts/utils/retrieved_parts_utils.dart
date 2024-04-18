import 'package:core_widgets/core_widgets.dart';

import '../../engineer/models/retreived_part_required_list_reponse.dart';

class RetrievedPartsUtils {
  static bool checkForMandatoryFields(List<RetrievedPartListResponseData?>? dataModelList) {
    if (!Validator.isListNullOrEmpty(dataModelList)) {
      for (var element in dataModelList!) {
        if (element?.s3Url == null || element?.barcode == null || element?.reasonId == null) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
