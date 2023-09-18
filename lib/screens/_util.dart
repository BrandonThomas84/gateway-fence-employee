import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/screens/home.dart';
import 'package:gateway_fence_employee/screens/settings.dart';
import 'package:gateway_fence_employee/screens/time_card.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';
import 'package:go_router/go_router.dart';

/// Get the routes for the app
final routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/time-card',
      builder: (context, state) => TimeCardScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

class CurrentRouteProvider extends ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}

class DefaultScreenScaffold extends StatefulWidget {
  final List<Widget> children;
  final String? title;

  const DefaultScreenScaffold({
    super.key,
    required this.children,
    this.title,
  });

  @override
  State<DefaultScreenScaffold> createState() => _DefaultScreenScaffoldState();
}

class _DefaultScreenScaffoldState extends State<DefaultScreenScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // add the widget title to the page
    if (widget.title != null) {
      widget.children.insert(
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
                widget.title!,
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Placeholder();
  }
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
