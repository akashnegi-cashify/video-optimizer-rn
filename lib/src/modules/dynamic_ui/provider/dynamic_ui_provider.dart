import 'dart:convert';

import 'package:components/components.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../model/dashboard_widget_detail.dart';

class DynamicUIProvider extends CshChangeNotifier {
  ServiceGroups serviceGroup;
  String endPath;
  int id;
  DashboardWidgetDetailsResponse? dashboardWidgetDetailsResponse;

  static DynamicUIProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DynamicUIProvider>(context, listen: listen);
  }

  DynamicUIProvider(this.serviceGroup, this.endPath, this.id) {
    getWidgetDetail(id);
  }


  getWidgetDetail(int id) {
    Stream.value(data).listen((event) {
      Logger.debug('DynamicUIProvider.getWidgetDetail', [event]);
      dashboardWidgetDetailsResponse = DashboardWidgetDetailsResponse.fromJson(jsonDecode(event));
      Logger.debug('DynamicUIProvider.getWidgetDetail', [event]);
    },onDone: (){

      notifyListeners();
    },onError: (error){
      Logger.debug('DynamicUIProvider.getWidgetDetail', [error]);
    });
  }



  // getWidgetDetail(int id) {
  //   var requestBody = {'id': id};
  //   ConsoleService(serviceGroup).post<DashboardWidgetDetailsResponse>(
  //     endPath,
  //     DashboardWidgetDetailsResponse.fromJson,
  //     headers: {...AppHeaders.xSSOToken},
  //     body: jsonEncode(requestBody),
  //   ).listen((event) {
  //     event.widgetList?.sort( (a,b) {
  //       int aPriority = a.priority ?? 0;
  //       int bPriority = b.priority ?? 0;
  //       return aPriority.compareTo(bPriority);
  //     });
  //     dashboardWidgetDetailsResponse = event;
  //
  //   }, onDone: () {
  //     notifyListeners();
  //   }, onError: (error) {
  //     Logger.debug('DynamicUIProvider.getWidgetDetail', [error]);
  //   });
  //
  // }
}
