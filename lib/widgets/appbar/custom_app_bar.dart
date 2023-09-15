import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/routes/home.dart';
import 'package:gateway_fence_employee/routes/time_sheet.dart';
import 'package:gateway_fence_employee/util/log.dart';

import 'custom_app_bar_item.dart';

enum RouteOwner {
  menu,
  home,
  timeCard,
}

class CustomAppBar extends StatelessWidget {
  final RouteOwner routeOwner;

  const CustomAppBar({
    super.key,
    this.routeOwner = RouteOwner.home,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customBottomAppBarButtons = [
      {
        "key": RouteOwner.menu,
        "text": 'Menu',
        "icon": Icons.menu_outlined,
        "onTap": () {
          Scaffold.of(context).openDrawer();
          Logger.error("Menu button pressed");
        }
      },
      {
        "key": RouteOwner.home,
        "text": 'Home',
        "icon": Icons.home_outlined,
        "onTap": () {
          if (routeOwner == RouteOwner.home) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeRoute()),
          );
        },
      },
      {
        "key": RouteOwner.timeCard,
        "text": 'Time card',
        "icon": Icons.event_available_outlined,
        "onTap": () {
          if (routeOwner == RouteOwner.timeCard) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimeSheetRoute()),
          );
        },
      },
    ];

    // calculate the button width
    final buttonWidth = MediaQuery.of(context).size.width *
        (1 / (customBottomAppBarButtons.length));

    return BottomAppBar(
      child: Container(
        color: AppColors.greyLight,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var btn in customBottomAppBarButtons)
              CustomAppBarItem(
                text: btn['text'],
                icon: btn['icon'],
                width: buttonWidth,
                onTap: btn['onTap'],
                color:
                    routeOwner == btn['key'] ? AppColors.blue : AppColors.grey,
                isLast: btn == customBottomAppBarButtons.last,
              ),
          ],
        ),
      ),
    );
  }
}
