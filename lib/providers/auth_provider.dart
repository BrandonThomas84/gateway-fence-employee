// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gateway_fence_employee/models/user.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:provider/provider.dart';

enum AuthStateChangeType {
  authStateChanges,
  userChanges,
  idTokenChanges,
  checkSessionState
}

const int defaultSessionDuration = 30;

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    // prepare the session timer
    setSessionTimer();
  }

  User? _user;
  User? get user => _user;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Timer? _sessionTimer;
  Timer? get sessionTimer => _sessionTimer;

  DateTime? _sessionStartTime;
  DateTime? get sessionStartTime => _sessionStartTime;

  @override
  void dispose() {
    killSessionTimer();
    super.dispose();
  }

  void setSessionTimer({int minutes = defaultSessionDuration}) {
    killSessionTimer();
    if (minutes == 0) {
      return;
    }

    _sessionStartTime = DateTime.now();
    _sessionTimer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      AppLogger.info('session timer check', data: <String, dynamic>{
        'ticks': timer.tick,
      });

      // check if the user is still logged in
      final User? user = FirebaseAuth.instance.currentUser;
      setUser(user, AuthStateChangeType.checkSessionState);
    });
  }

  void killSessionTimer() {
    _sessionTimer?.cancel();
  }

  /// Sets the user and updates the provider
  void setUser(User? user, AuthStateChangeType changeType) {
    _user = user;
    _isAuthenticated = user != null;

    switch (changeType) {
      case AuthStateChangeType.authStateChanges:
        _doAuthStateChanges();
        break;
      case AuthStateChangeType.userChanges:
        _doUserChanges();
        break;
      case AuthStateChangeType.idTokenChanges:
        _doIdTokenChanges();
        break;
      case AuthStateChangeType.checkSessionState:
        _doCheckSessionState();
        break;
      default:
        AppLogger.warn('unknown auth state change type: $changeType');
        return;
    }

    setSessionTimer(minutes: _isAuthenticated ? defaultSessionDuration : 0);

    notifyListeners();
  }

  void _doAuthStateChanges() {
    AppLogger.trace('auth state changes');
  }

  void _doUserChanges() {
    AppLogger.trace('user changes');
  }

  void _doIdTokenChanges() {
    AppLogger.trace('id token changes');
  }

  void _doCheckSessionState() {
    AppLogger.trace('check session state');
  }
}

/// Sets up the auth state change listeners for the app
void setupAuthStateChanges(BuildContext context) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    context
        .read<AuthProvider>()
        .setUser(user, AuthStateChangeType.authStateChanges);
  });

  FirebaseAuth.instance.userChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, AuthStateChangeType.userChanges);
  });

  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    context
        .read<AuthProvider>()
        .setUser(user, AuthStateChangeType.idTokenChanges);
  });
}
