// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'menu_item.dart';

class MenutItemConfig {
  MenutItemConfig({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;
}

class Menu extends StatelessWidget {
  Menu({
    super.key,
  });

  final List<MenutItemConfig> secureItems = <MenutItemConfig>[
    MenutItemConfig(
      title: 'Home',
      icon: Icons.home_outlined,
      route: '/',
    ),
    MenutItemConfig(
      title: 'Time Card',
      icon: Icons.timer_outlined,
      route: '/time-card',
    ),
    MenutItemConfig(
      title: 'Profile',
      icon: Icons.person_2_outlined,
      route: '/profile',
    ),
    MenutItemConfig(
      title: 'Settings',
      icon: Icons.settings_outlined,
      route: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated =
        Provider.of<AuthProvider>(context).isAuthenticated;

    return SizedBox(
      height: (MediaQuery.of(context).size.height * .75) - 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              if (isAuthenticated)
                for (MenutItemConfig item in secureItems)
                  MenuItem(
                    title: item.title,
                    icon: item.icon,
                    onTap: () {
                      Provider.of<CurrentRouteProvider>(context, listen: false)
                          .setCurrentRoute(item.route, context);
                    },
                    isActive: GoRouterState.of(context).fullPath == item.route,
                  ),
              if (isAuthenticated)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MenuItem(
                    title: 'Logout',
                    icon: Icons.logout_rounded,
                    onTap: () {
                      Provider.of<CurrentRouteProvider>(context, listen: false)
                          .setCurrentRoute('/logout', context);
                    },
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
