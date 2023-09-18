import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'menu_item.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * .75) - 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              MenuItem(
                title: 'Home',
                icon: Icons.home_outlined,
                onTap: () {
                  // navigate to profile page
                  context.go('/');
                },
                isActive: GoRouterState.of(context).fullPath == '/',
              ),
              MenuItem(
                title: 'Time Card',
                icon: Icons.timer_rounded,
                onTap: () {
                  // navigate to profile page
                  context.go('/time-card');
                },
                isActive: GoRouterState.of(context).fullPath == '/time-card',
              ),
              MenuItem(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  // navigate to profile page
                  context.go('/settings');
                },
                isActive: GoRouterState.of(context).fullPath == '/settings',
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MenuItem(
              title: 'Logout',
              icon: Icons.logout_rounded,
                onTap: () {
                  // navigate to profile page
                  context.go('/profile');
                },
            ),
          )
        ],
      ),
    );
  }
}
