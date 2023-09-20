
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';
import 'login.dart';
import 'logout.dart';
import 'register.dart';
import 'settings.dart';
import 'time_card.dart';

/// Get the routes for the app
final routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    homeScreenGoRoute,
    loginScreenGoRoute,
    logoutScreenGoRoute,
    registerScreenGoRoute,
    settingsScreenGoRoute,
    timeCardScreenGoRoute,
  ],
);