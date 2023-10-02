// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:gateway_fence_employee/util/log.dart';
// Package imports:
import 'package:go_router/go_router.dart';

/// Provider to keep track of the current route
class CurrentRouteProvider extends ChangeNotifier {
  String _currentRoute = '/';
  String _previousRoute = '/';

  String get currentRoute => _currentRoute;
  String get previousRoute => _previousRoute;

  void setCurrentRoute(String route, BuildContext context) {
    if (_currentRoute == route) {
      AppLogger.warn('route is already set to $route');
      return;
    }

    _previousRoute = _currentRoute;
    _currentRoute = route;

    notifyListeners();

    AppLogger.trace('navigation request', data: <String, String>{
      'previousRoute': _previousRoute,
      'currentRoute': _currentRoute,
    });

    GoRouter.of(context).go(route);
  }

  void goBack(BuildContext context) {
    setCurrentRoute(_previousRoute, context);
  }

  void logout(BuildContext context) {
    setCurrentRoute('/logout', context);
  }
}
