import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gateway_fence_employee/config/colors.dart';
// import 'package:gateway_fence_employee/routes/home.dart';
// import 'package:gateway_fence_employee/routes/time_sheet.dart';
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
    required this.routeOwner,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final List<CustomAppBarItem> buttons = [
      CustomAppBarItem(
        tooltipMessage: "Open menu",
        width: 20.0,
        icon: const ProfileImage(imageSize: 40, borderThickness: 1.5),
        onTap: () {
          Scaffold.of(context).openDrawer();
          Logger.error("Menu button pressed");
        },
      ),
      CustomAppBarItem(
        tooltipMessage: 'Home',
        width: 50.0,
        icon: Icon(
          Icons.home_outlined,
          color: routeOwner == RouteOwner.home
              ? AppColors.blue
              : AppColors.greyLight,
        ),
        onTap: () {
          GoRouter.of(context).go('/');
        },
      ),
      CustomAppBarItem(
        tooltipMessage: 'Time card',
        width: 50.0,
        icon: Icon(
          Icons.event_available_outlined,
          color: routeOwner == RouteOwner.timeCard
              ? AppColors.blue
              : AppColors.greyLight,
        ),
        onTap: () {
          GoRouter.of(context).go('/time-card');
        },
        isLast: true,
      ),
    ];
    return BottomAppBar(
      child: Container(
        color: AppColors.grey,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttons,
        ),
      ),
    );
  }
}
