import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class StockTransferService {
  static Stream<StockTransferListResponse?> getStockTransferList({bool? isStoreOut = false}) {
    return QcService().get("/transfer-lot/list-lots?isStoreOut=$isStoreOut", StockTransferListResponse.fromJson);
  }

// static Stream<BaseResponse?> skipReQc(String? lotName) {
//   return QcService().post("/lot-re-qc/v3/skip-re-qc?lgn=$lotName", BaseResponse.fromJson);
// }
}
