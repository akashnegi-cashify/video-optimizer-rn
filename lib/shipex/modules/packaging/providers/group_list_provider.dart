import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/group_list_repsonse_data_model.dart';
import '../resouces/packing_service.dart';

class GroupListProvider extends CshChangeNotifier {
  //Pending list properties
  bool pendingDataLoading = false;
  String? pendingErrorListMessage;
  List<GroupListDataResponse>? groupDataPendingList;
  List<GroupListDataResponse> localSearchResultsData = [];

  static GroupListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<GroupListProvider>(context, listen: listen);
  }

  fetchPendingDataList() {
    pendingDataLoading = true;
    notifyListeners();
    PackingService.getGroupPendingDataList().listen((event) {
      if (!Validator.isListNullOrEmpty(event?.groupDataList)) {
        groupDataPendingList = event!.groupDataList!;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------GroupListProvider.fetchPendingDataList', [em]);
      pendingErrorListMessage = em;
    }, onDone: () {
      pendingDataLoading = false;
      notifyListeners();
    });
  }

  Future<GroupListResponseModel> fetchNewDataListData(int pageNumber, {String? query}) {
    var completer = Completer<GroupListResponseModel>();
    try {
      PackingService.getGroupNewDataList(pageNumber, query: query).listen((event) {
        if (event != null && !Validator.isListNullOrEmpty(event.groupDataList)) {
          completer.complete(event);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------GroupListProvider.fetchNewDataListData', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  fetchLocalSearchResultsInPending(String query) {
    pendingDataLoading = true;
    notifyListeners();
    localSearchResultsData.clear();
    if (query.isEmpty) {
      localSearchResultsData = [];
    } else {
      localSearchResultsData = groupDataPendingList!.where((element) {
        if (!Validator.isNullOrEmpty(element.name)) {
          return element.name!.toLowerCase().contains(query);
        } else {
          return false;
        }
      }).toList();
    }
    pendingDataLoading = false;
    notifyListeners();
  }
}
