import 'package:flutter/material.dart';

class CshRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static final CshRouteObserver _instance = CshRouteObserver._internal();

  List<PageRoute<dynamic>> pageRouteStack = [];

  factory CshRouteObserver() {
    return _instance;
  }

  CshRouteObserver._internal();

  get instance => _instance;

  PageRoute? _lastReplacedRoute;

  openScreenBeforeInternetError(BuildContext context, String noInternetScreenRouteName) {
    if (_lastReplacedRoute != null && isLastRouteIsNoInternet(noInternetScreenRouteName)) {
      Navigator.of(context).pushReplacementNamed(
        _lastReplacedRoute!.settings.name!,
        arguments: _lastReplacedRoute!.settings.arguments,
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _addToStack(route);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) {
      _popFromStack(route);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route is PageRoute) {
      _removeRoutes(route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _replaceLastRoute(newRoute);
    }
  }

  bool isRouteExist(String route) {
    for (var element in pageRouteStack) {
      if (element.settings.name == route) {
        return true;
      }
    }
    return false;
  }

  popTill(BuildContext context, String route) {
    for (int i = 0; i < pageRouteStack.length; i++) {
      print('pageRouteStack[$i] = ${pageRouteStack[i].settings.name}');
      if (pageRouteStack[i].settings.name == route) {
        Navigator.popUntil(context, ModalRoute.withName(route));
        if (i > 0 && (pageRouteStack[i - 1].settings.name) != null) {
          Navigator.popUntil(context, ModalRoute.withName((pageRouteStack[i - 1].settings.name)!));
        }
      }
    }
    Navigator.pushNamed(context, route);
  }

  _removeRoutes(PageRoute<dynamic> route) {
    if (route != null) {
      pageRouteStack.remove(route);
    }
  }

  _replaceLastRoute(PageRoute<dynamic> route) {
    _lastReplacedRoute = pageRouteStack.removeLast();
    pageRouteStack.add(route);
  }

  _addToStack(PageRoute<dynamic> route) {
    pageRouteStack.add(route);
  }

  _popFromStack(PageRoute<dynamic> route) {
    if (pageRouteStack.isNotEmpty) {
      pageRouteStack.removeLast();
    }

    if (_lastReplacedRoute != null && _lastReplacedRoute == route) {
      _lastReplacedRoute = null;
    }
  }

  isLastRouteIsNoInternet(String noInternetScreenRouteName) {
    if (pageRouteStack.isEmpty) {
      return false;
    }
    var lastRouteName = pageRouteStack.last.settings.name ?? "";
    return lastRouteName == noInternetScreenRouteName;
  }
}
