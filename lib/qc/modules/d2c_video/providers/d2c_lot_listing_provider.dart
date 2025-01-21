import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_list_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_video_service.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class D2cLotListingProvider extends CshChangeNotifier with Searchable {
  List<D2cLotListData>? _d2cLotList;

  static D2cLotListingProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<D2cLotListingProvider>(context, listen: listen);
  }

  List<D2cLotListData>? get d2cLotList => Validator.isNullOrEmpty(searchQuery)
      ? _d2cLotList
      : _d2cLotList
          ?.where((element) => element.groupLotName?.toLowerCase().contains(searchQuery!.toLowerCase()) ?? false)
          .toList();

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  Future<void> getLotList() {
    var completer = Completer<void>();
    D2CVideoService.getLotList().listen(
      (event) {
        _d2cLotList = event.d2cLotList;
        completer.complete();
      },
      onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      },
    );
    return completer.future;
  }
}
