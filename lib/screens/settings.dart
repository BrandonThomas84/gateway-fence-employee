// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'default_screen_scaffold.dart';

GoRoute settingsScreenGoRoute = GoRoute(
  path: '/settings',
  builder: (BuildContext context, GoRouterState state) => const SettingsScreen(),
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
      children: const <Widget>[
        Column(
          children: <Widget>[
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
      ],
    );
  }
}
