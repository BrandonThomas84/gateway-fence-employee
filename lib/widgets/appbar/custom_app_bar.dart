import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/routes/home.dart';
import 'package:gateway_fence_employee/routes/time_sheet.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/sidebar/profile_image.dart';

import 'custom_app_bar_item.dart';

enum RouteOwner {
  menu,
  home,
  timeCard,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RouteOwner routeOwner;

  const CustomAppBar({
    super.key,
    this.routeOwner = RouteOwner.home,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customBottomAppBarButtons = [
      {
        "key": RouteOwner.menu,
        "tooltipMessage": "View menu",
        "icon": const ProfileImage(imageSize: 20, borderThickness: 1.5),
        "onTap": () {
          Scaffold.of(context).openDrawer();
          Logger.error("Menu button pressed");
        }
      },
      {
        "key": RouteOwner.home,
        "tooltipMessage": 'Home',
        "icon": const Icon(Icons.home_outlined),
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
        "tooltipMessage": 'Time card',
        "icon": const Icon(Icons.event_available_outlined),
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
        color: AppColors.grey,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var btn in customBottomAppBarButtons)
              CustomAppBarItem(
                tooltipMessage: btn['text'] ?? "",
                icon: btn['icon'],
                width: buttonWidth,
                onTap: btn['onTap'],
                color: routeOwner == btn['key']
                    ? AppColors.blue
                    : AppColors.greyLight,
                isLast: btn == customBottomAppBarButtons.last,
              ),
          ],
        ),
      ),
    );
  }
}
