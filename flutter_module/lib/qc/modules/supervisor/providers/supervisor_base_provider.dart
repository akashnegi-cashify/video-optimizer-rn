import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

base class SupervisorBaseProvider extends CshChangeNotifier with Searchable {
  static SupervisorBaseProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SupervisorBaseProvider>(context, listen: listen);
  }

  List<PartVariationData>? _partVariationList;

  set partVariationList(List<PartVariationData>? value) {
    _partVariationList = value;
    notifyListeners();
  }

  SupervisorBaseProvider({List<PartVariationData>? partVariationListResponse}) {
    _partVariationList = partVariationListResponse;
  }

  List<PartVariationData>? get partVariationList => Validator.isNullOrEmpty(searchQuery)
      ? _partVariationList
      : _partVariationList
          ?.where((element) => element.partName!.toLowerCase().contains(searchQuery!.toLowerCase()))
          .toList();

  List<PartVariationData>? getCompletePartVariationList() => _partVariationList;

  void updateImage(int partId, String imageUrl) {
    var index = partVariationList?.indexWhere((element) => element.partId == partId);
    if (index != null && index > -1) {
      partVariationList![index].imageUrl = imageUrl;
      notifyListeners();
    }
  }

  void updateUserSelectedVariantId(int partId, String variantId) {
    var index = partVariationList?.indexWhere((element) => element.partId == partId);
    if (index != null && index > -1) {
      partVariationList![index].userSelectedVariantId = variantId;
      notifyListeners();
    }
  }

  void resetQuestion(int partId) {
    var index = partVariationList?.indexWhere((element) => element.partId == partId);
    if (index != null && index > -1) {
      partVariationList![index].userSelectedVariantId = null;
      partVariationList![index].imageUrl = null;
      notifyListeners();
    }
  }

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
