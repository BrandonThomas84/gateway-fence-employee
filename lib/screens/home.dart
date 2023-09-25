// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/screens/login.dart';
import 'package:gateway_fence_employee/util/config.dart';
import 'default_screen_scaffold.dart';

GoRoute homeScreenGoRoute = GoRoute(
  path: '/',
  builder: (BuildContext context, GoRouterState state) {
    return Provider.of<AuthProvider>(context).isAuthenticated
        ? const HomeScreen()
        : const LoginScreen();
  },
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: companyName,
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.greyLight,
                width: 1,
              ),
            ),
          ),
          child: const Center(
            heightFactor: 30,
            child: Text('You ARE logged in.'),
          ),
        ),
      ],
    );
  }
}