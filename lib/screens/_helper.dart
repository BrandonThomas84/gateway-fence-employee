import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';
import 'logout.dart';
import 'settings.dart';
import 'time_card.dart';

/// Get the routes for the app
final routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    homeScreenGoRoute,
    timeCardScreenGoRoute,
    settingsScreenGoRoute,
    logoutScreenGoRoute,
  ],
);

/// Provider to keep track of the current route
class CurrentRouteProvider extends ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}

/// Scaffold with a drawer and a floating action button
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

/// The state of the DefaultScreenScaffold widget
class _DefaultScreenScaffoldState extends State<DefaultScreenScaffold>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebar(),
      backgroundColor: AppColors.greyLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(Icons.menu),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            if (widget.title != null)
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
            ...widget.children,
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
