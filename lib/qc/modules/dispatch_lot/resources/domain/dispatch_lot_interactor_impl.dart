import '../index.dart';
import '../services.dart';
import 'dispatch_lot_interactor.dart';

class DispatchLotInteractorImpl implements DispatchLotInteractor {
  @override
  Stream<DispatchLotsResponse?> getData(int pageIndex, int pageSize, {String? searchQuery, List<int>? lotType}) {
    DispatchLotRequest request = DispatchLotRequest();
    request.pageNo = pageIndex;
    request.pageSize = pageSize;
    request.searchQuery = searchQuery;
    request.lotType = lotType;
    return DispatchLotServices.getData(request);
  }
}
