import 'package:flutter/material.dart';

import 'menu_item.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MenuItem(
          title: 'My Profile',
          icon: Icons.account_circle_rounded,
        ),
        MenuItem(
          title: 'Settings',
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Time Sheet',
          icon: Icons.timer_rounded,
        ),
        MenuItem(
          title: 'Logout',
          icon: Icons.logout_rounded,
        ),
      ],
    );
  }
}
