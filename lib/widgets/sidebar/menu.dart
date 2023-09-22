import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';

import 'menu_item.dart';

class MenutItemConfig {
  final String title;
  final IconData icon;
  final String route;

  MenutItemConfig({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class Menu extends StatelessWidget {
  Menu({
    super.key,
  });

  final List<MenutItemConfig> secureItems = [
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
    MenutItemConfig(
      title: 'Reauthenticate',
      icon: Icons.security_outlined,
      route: '/reauth',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = Provider.of<AuthProvider>(context).isAuthenticated;

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
                      .setCurrentRoute('/', context);
                },
                isActive: GoRouterState.of(context).fullPath == '/',
              ),
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
                  )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MenuItem(
              title: isAuthenticated ? 'Logout' : 'Login',
              icon: Icons.logout_rounded,
              onTap: () {
                String newRoute = isAuthenticated ? '/logout' : '/login';
                Provider.of<CurrentRouteProvider>(context, listen: false)
                    .setCurrentRoute(newRoute, context);
              },
            ),
          )
        ],
      ),
    );
  }
}
