import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:go_router/go_router.dart';

/// Provider to keep track of the current route
class CurrentRouteProvider extends ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  void setCurrentRoute(String route, BuildContext context) {
    _currentRoute = route;
    notifyListeners();
    Logger.info('current route changed to $route');
    context.go(route);
  }
}