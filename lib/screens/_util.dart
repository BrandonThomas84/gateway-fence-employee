import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/screens/home.dart';
import 'package:gateway_fence_employee/screens/settings.dart';
import 'package:gateway_fence_employee/screens/time_card.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';
import 'package:go_router/go_router.dart';

/// Get the routes for the app
GoRouter getRoutes() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeRoute(),
      ),
      GoRoute(
        path: '/time-card',
        builder: (context, state) => TimeCardRoute(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsRoute(),
      ),
    ],
  );
}

/// Scaffold with a drawer and a floating action button
Scaffold defaultScreenScaffold({
  required List<Widget> children,
  String? title,
}) {
  // add the title to the page
  if (title != null) {
    children.insert(
      0,
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyLight,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  return Scaffold(
    key: scaffoldKey,
    drawer: const Sidebar(),
    backgroundColor: AppColors.greyLight,
    // appBar: const CustomAppBar(routeOwner: RouteOwner.home),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // open the drawern
        scaffoldKey.currentState?.openDrawer();
      },
      child: const Icon(Icons.menu),
    ),
    body: SafeArea(
      child: ListView(
        children: children,
      ),
    ),
  );
}
