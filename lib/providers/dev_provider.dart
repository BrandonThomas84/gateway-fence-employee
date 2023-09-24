// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/util/config.dart';
import 'package:gateway_fence_employee/util/log.dart';

/// Provider to keep track of the current route
class DevProvider extends ChangeNotifier {
  bool _isDevMode = false;

  DevProvider() {
    _isDevMode = appVarEnvironment == 'dev';
    if (_isDevMode) {
      Logger.info('DevProvider initialized');
    }
  }

  bool get isDevMode => _isDevMode;
}
