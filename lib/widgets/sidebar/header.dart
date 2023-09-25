// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';

// Project imports:
import 'package:gateway_fence_employee/widgets/sidebar/profile.dart';
import 'package:gateway_fence_employee/widgets/sidebar/status_timer.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated =
        Provider.of<AuthProvider>(context).isAuthenticated;

    final String currentRoute =
        Provider.of<CurrentRouteProvider>(context, listen: false).currentRoute;

    return DefaultTextStyle.merge(
      style: const TextStyle(
        color: Colors.white,
      ),
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Profile(imageSize: 60),
            isAuthenticated
                ? const StatusTimer()
                : Center(
                    child: Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            // if already on the login screen just close the drawer
                            if (currentRoute == '/login') {
                              Scaffold.of(context).closeDrawer();
                            } else {
                              Provider.of<CurrentRouteProvider>(context,
                                      listen: false)
                                  .setCurrentRoute('/login', context);
                            }
                          },
                          child: const Text(
                            'Click here to login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
