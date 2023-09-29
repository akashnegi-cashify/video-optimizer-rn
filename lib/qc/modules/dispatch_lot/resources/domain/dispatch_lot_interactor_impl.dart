import '../index.dart';
import '../services.dart';
import 'dispatch_lot_interactor.dart';

class DispatchLotInteractorImpl implements DispatchLotInteractor {
  @override
  Stream<DispatchLotsResponse?> getData(int pageIndex, int pageSize, {String? searchQuery, String? channelQuery}) {
    DispatchLotRequest request = DispatchLotRequest();
    request.pageNo = pageIndex;
    request.pageSize = pageSize;
    request.searchQuery = searchQuery;
    request.channelQuery = channelQuery;
    return DispatchLotServices.getData(request);
  }
}
