// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:gateway_fence_employee/util/log.dart';

/// Provider to keep track of the current route
class CurrentRouteProvider extends ChangeNotifier {
  String _currentRoute = '/';
  String _previousRoute = '/';

  String get currentRoute => _currentRoute;
  String get previousRoute => _previousRoute;

  void setCurrentRoute(String route, BuildContext context) {
    _previousRoute = _currentRoute;
    _currentRoute = route;
    notifyListeners();
    Logger.info('navigation', data: {
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
