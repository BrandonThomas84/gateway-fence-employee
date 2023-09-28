// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:gateway_fence_employee/screens/default_screen_scaffold.dart';

GoRoute logoutScreenGoRoute = GoRoute(
  path: '/logout',
  builder: (BuildContext context, GoRouterState state) => const LogoutScreen(),
);

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({
    super.key,
  });

  Future<void> doSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    doSignOut();
    return DefaultScreenScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: const <Widget>[
        Center(
          heightFactor: 30,
          child: Text('You have been logged out.'),
        ),
      ],
    );
  }
}
