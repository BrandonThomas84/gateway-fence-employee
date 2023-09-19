import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/config.dart';
import 'package:go_router/go_router.dart';
import '_helper.dart';

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
    return DefaultScreenScaffold(
      title: companyName,
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
          child: const Column(
            children: [
              Text('some stuff'),
            ],
          ),
        ),
      ],
    );
  }
}
