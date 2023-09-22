import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';
import 'login.dart';
import 'logout.dart';
import 'profile.dart';
import 'reauth.dart';
import 'register.dart';
import 'settings.dart';
import 'time_card.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    homeScreenGoRoute,
    loginScreenGoRoute,
    logoutScreenGoRoute,
    profileScreenGoRoute,
    reauthScreenGoRoute,
    registerScreenGoRoute,
    settingsScreenGoRoute,
    timeCardScreenGoRoute,
  ],
);
