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

  @override
  Widget build(BuildContext context) {
    return const DefaultScreenScaffold(
      children: [
        Center(
          heightFactor: 30,
          child: Text('You have successfully logged out.'),
        ),
      ],
    );
  }
}
