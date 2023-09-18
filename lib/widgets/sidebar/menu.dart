import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/screens/_util.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                  Provider.of<CurrentRouteProvider>(context, listen: false)
                      .setCurrentRoute('/');
                  // navigate to profile page
                  context.go('/');
                },
                isActive: GoRouterState.of(context).fullPath == '/',
              ),
              MenuItem(
                title: 'Time Card',
                icon: Icons.timer_rounded,
                onTap: () {
                  Provider.of<CurrentRouteProvider>(context, listen: false)
                      .setCurrentRoute('/time-card');
                  // navigate to profile page
                  context.go('/time-card');
                },
                isActive: GoRouterState.of(context).fullPath == '/time-card',
              ),
              MenuItem(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  Provider.of<CurrentRouteProvider>(context, listen: false)
                      .setCurrentRoute('/settings');
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
                  Provider.of<CurrentRouteProvider>(context, listen: false)
                      .setCurrentRoute('/logout');
                // navigate to profile page
                context.go('/logout');
              },
            ),
          )
        ],
      ),
    );
  }
}
