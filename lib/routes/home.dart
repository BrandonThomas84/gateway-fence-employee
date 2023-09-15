import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/widgets/appbar/custom_app_bar.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: Sidebar(),
      backgroundColor: AppColors.greyDark,
      bottomNavigationBar: CustomAppBar(routeOwner: RouteOwner.home),
      body: SafeArea(
        child: Column(
          children: [
            Text("some stuff"),
          ],
        ),
      ),
    );
  }
}
