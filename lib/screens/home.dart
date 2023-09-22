import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/screens/login.dart';
import 'package:gateway_fence_employee/util/config.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'default_screen_scaffold.dart';

GoRoute homeScreenGoRoute = GoRoute(
  path: '/',
  builder: (context, state) => const HomeScreen(),
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = Provider.of<AuthProvider>(context).isAuthenticated;

    return isAuthenticated
        ? const HomeAuthenticated()
        : const LoginScreen();
  }
}

class HomeAuthenticated extends StatelessWidget {
  const HomeAuthenticated({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: companyName,
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: [
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
