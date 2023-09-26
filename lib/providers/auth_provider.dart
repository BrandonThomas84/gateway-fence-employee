// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gateway_fence_employee/models/user.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  /// Sets the user and updates the provider
  void setUser(User? user, String changeType) {
    _user = user;
    _isAuthenticated = user != null;

    _userModel = UserModel.fromJson(<String, dynamic>{
      'userId': user?.uid,
      'displayName': user?.displayName,
      'email': user?.email,
      'phone': user?.phoneNumber,
      'created': user?.metadata.creationTime?.millisecondsSinceEpoch.toString(),
      'modified': user?.metadata.lastSignInTime?.millisecondsSinceEpoch.toString(),
    });
    notifyListeners();
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
