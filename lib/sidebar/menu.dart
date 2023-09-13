import 'package:flutter/material.dart';

import 'menu_item.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * .75) - 120,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              MenuItem(
                title: 'My Profile',
                icon: Icons.account_circle_rounded,
              ),
              MenuItem(
                title: 'Time Sheet',
                icon: Icons.timer_rounded,
              ),
              MenuItem(
                title: 'Settings',
                icon: Icons.settings,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MenuItem(
              title: 'Logout',
              icon: Icons.logout_rounded,
            ),
          )
        ],
      ),
    );
  }
}
