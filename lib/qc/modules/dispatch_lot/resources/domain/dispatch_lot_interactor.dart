import '../index.dart';

abstract class DispatchLotInteractor {
  Stream<DispatchLotsResponse?> getData(int pageIndex, int pageSize, {String? searchQuery, List<String>? lotType});
}
