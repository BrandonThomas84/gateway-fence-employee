import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:go_router/go_router.dart';

GoRoute logoutScreenGoRoute = GoRoute(
  path: '/logout',
  builder: (context, state) => const LogoutScreen(),
);

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({
    super.key,
  });

  void doSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    doSignOut();
    return DefaultScreenScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: const [
        Center(
          heightFactor: 30,
          child: Text('You have successfully logged out.'),
        ),
      ],
    );
  }
}
