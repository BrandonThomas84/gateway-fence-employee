import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

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
    } else {
      Logger.info('setUser provider called ($changeType), user is not logged in');

      // unset the authenticated flag
      _isAuthenticated = false;
    }

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
