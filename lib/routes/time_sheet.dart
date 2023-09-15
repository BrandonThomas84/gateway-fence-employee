import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/widgets/appbar/custom_app_bar.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/widgets/shifts/shift.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';
import 'package:gateway_fence_employee/widgets/shifts/shift_list.dart';

class TimeSheetRoute extends StatelessWidget {
  TimeSheetRoute({super.key});

  final List<Shift> eventList = [
    const Shift(text: 'My Event 1', time: '12:34:45 PM'),
    const Shift(text: 'My Event 2', time: '12:35:45 PM'),
    const Shift(text: 'My Event 3', time: '12:36:45 PM'),
    const Shift(text: 'My Event 4', time: '12:37:45 PM'),
    const Shift(text: 'My Event 5', time: '12:38:45 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      backgroundColor: AppColors.greyDark,
      bottomNavigationBar: const CustomAppBar(
        routeOwner: RouteOwner.timeCard,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ShiftList(eventList: eventList),
          ],
        ),
      ),
    );
  }
}
