import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:console_flutter_template/src/modules/dynamic_ui/model/dashboard_widget_detail.dart';
import 'package:console_flutter_template/src/modules/dynamic_ui/model/widget_data_request.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/widget_data_response.dart';

class WidgetDataProvider extends CshChangeNotifier {
  final String widgetKey;
  final String endPath;
  final ServiceGroups serviceGroup;
  final List<TemplateFilterList> templateFilters;
  WidgetDataResponse? widgetDataResponse;

  static WidgetDataProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WidgetDataProvider>(context, listen: listen);
  }

  WidgetDataProvider({
    required this.widgetKey,
    required this.endPath,
    required this.serviceGroup,
    required this.templateFilters,
  }) {
    getData();
  }

  getData() {
    ConsoleService(serviceGroup)
        .post<WidgetDataResponse>(
      endPath,
      WidgetDataResponse.fromJson,
      headers: {...AppHeaders.xSSOToken},
      body: jsonEncode(WidgetDateRequest(
        widgetKey: widgetKey,
        templateFilters: [],
      )),
    )
        .listen((event) {
          event.columns?.sort((a,b){
            int aPriority = a.priority ?? 0;
            int bPriority = b.priority ?? 0;
            return aPriority.compareTo(bPriority);
          });
      widgetDataResponse = event;
    }, onDone: () {
      notifyListeners();
    }, onError: (error) {
      Logger.debug('WidgetDataProvider.getData', [error]);
      String? errorMsg = ApiErrorHelper.getErrorMessage(error);
      Logger.debug('WidgetDataProvider.getData', [errorMsg]);
    });
  }
}
