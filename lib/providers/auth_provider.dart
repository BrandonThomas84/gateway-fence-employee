// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gateway_fence_employee/models/user.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  /// Sets the user and updates the provider
  void setUser(User? user, String changeType) {
    AppLogger.trace('AuthProvider.setUser: $changeType');
    _user = user;
    _isAuthenticated = user != null;

    notifyListeners();
  }

  void updateUserDocument(User? user) {
    // final UserModel userModel = UserModel.fromJson(<String, dynamic>{
    //   'userId': user?.uid ?? const Uuid(),
    //   'displayName': user?.displayName ?? '',
    //   'email': user?.email ?? '',
    //   'phone': user?.phoneNumber ?? '',
    //   'created':
    //       user?.metadata.creationTime?.millisecondsSinceEpoch.toString() ?? '',
    //   'modified': DateTime.now().millisecondsSinceEpoch.toString(),
    // });

    AppLogger.trace('Preparing to update user document:');
  }
}

void setupAuthStateChanges(BuildContext context) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'auth_state_changes');
  });

  FirebaseAuth.instance.userChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'user_changes');
    context.read<AuthProvider>().updateUserDocument(user);
  });

  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    context.read<AuthProvider>().setUser(user, 'id_token_changes');
  });
}
