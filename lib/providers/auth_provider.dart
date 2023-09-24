// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

const int reauthenticateFrequencySeconds = 15;

class ReauthRequest {
  final DateTime _requested = DateTime.now();
  DateTime? _completed;
  int _completionChecks = 0;

  bool get isCompleted => _completed != null;

  void setComplete() {
    _completed = DateTime.now();
  }

  /// Returns whether or not the reauthentication request is valid
  bool isValid() {
    if (_completed == null) {
      return false;
    }
    if (_completionChecks > 0) {
      return false;
    }

    if (_completed!.difference(_requested) <=
        const Duration(seconds: reauthenticateFrequencySeconds)) {
      _completionChecks++;
      return true;
    }
    
    return false;
  }
}

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _user;

  /// A list of keys that pertain to specified reauthentication requests
  final Map<String, ReauthRequest> _availableReauths = {};

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  /// Sets the user and updates the provider
  void setUser(User? user, String changeType) {
    _user = user;

    if (user != null) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }

    notifyListeners();
  }

  ReauthRequest getReauth(String changeType) {
    if (!_availableReauths.keys.contains(changeType)) {
      _availableReauths[changeType] = ReauthRequest();
    }

    return _availableReauths[changeType]!;
  }

  void completeReauth(String changeType) {
    getReauth(changeType).setComplete();
    notifyListeners();
  }

  /// Removes the specified reauthentication request from the map
  void removeReauth(String changeType) {
    _availableReauths.remove(changeType);
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
