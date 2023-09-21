import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:go_router/go_router.dart';

GoRoute settingsScreenGoRoute = GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingsScreen(),
);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: 'Settings',
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
          child: const Column(
            children: [
              Text('setting #1'),
              Text('setting #2'),
              Text('setting #3'),
              Text('setting #4'),
              Text('setting #5'),
              Text('setting #6'),
              Text('setting #7'),
              Text('setting #8'),
              Text('setting #9'),
              Text('setting #10'),
            ],
          ),
        ),
      ],
    );
  }
}
