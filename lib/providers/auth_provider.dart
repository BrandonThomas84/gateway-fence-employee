import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:provider/provider.dart';

const int reauthenticateFrequencySeconds = 60;

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _user;
  DateTime? _lastRefreshed;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  DateTime? get lastRefreshed => _lastRefreshed;

  /// Sets the user and updates the provider
  void setUser(User? user, String changeType) {
    _user = user;

    if (user != null) {
      Logger.info(
        'setUser provider called ($changeType), user is known',
        data: {
          'uid': user.uid,
          'user': user.displayName,
          'email': user.email,
          'phoneNumber': user.phoneNumber,
          'verified': user.emailVerified,
        },
      );
      
      // set the user as authenticated
      _isAuthenticated = true;
      _lastRefreshed = DateTime.now();
    } else {
      Logger.info('setUser provider called ($changeType), user is not logged in');

      // unset the authenticated flag
      _isAuthenticated = false;
    }

    notifyListeners();
  }

  void markRefreshed() {
    _lastRefreshed = DateTime.now();
    notifyListeners();
  }

  /// Returns the duration since the last time the user was refreshed.
  /// If the user has never been refreshed, this will return 0
  Duration getRefreshDuration() {
    if (_lastRefreshed == null) {
      return const Duration(seconds: 0);
    }

    return DateTime.now().difference(_lastRefreshed!);
  }

  /// Returns whether or not the user should be reauthenticated.
  /// This is caluclated using the value of the constant 
  /// `reauthenticateFrequencySeconds`
  bool shouldReauthenticate() {
    return getRefreshDuration() > const Duration(seconds: reauthenticateFrequencySeconds);
  }
}


void setupAuthStateChanges(BuildContext context) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'auth_state_changes');
  });

  FirebaseAuth.instance.userChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'user_changes');
  });

  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'id_token_changes');
  });
}
