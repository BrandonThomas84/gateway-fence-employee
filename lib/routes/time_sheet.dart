import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/appbar/custom_app_bar.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/sidebar/sidebar.dart';

class TimeSheetRoute extends StatelessWidget {
  const TimeSheetRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: Sidebar(),
      backgroundColor: AppColors.greyDark,
      bottomNavigationBar: CustomAppBar(
        routeOwner: RouteOwner.timeCard,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("some stuff here")
          ],
        ),
      ),
    );
  }
}
