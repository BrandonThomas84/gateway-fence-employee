import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:go_router/go_router.dart';

GoRoute loginScreenGoRoute = GoRoute(
  path: '/login',
  builder: (context, state) => const LoginScreen(),
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DefaultScreenScaffold(
      children: [
        Center(
          heightFactor: 30,
          child: Column(children: [
            Row(
              children: [
                Text("Login"),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
