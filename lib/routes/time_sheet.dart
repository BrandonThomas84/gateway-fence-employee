import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/test/mocks/shifts.dart';
import 'package:uuid/uuid.dart';

import 'package:gateway_fence_employee/widgets/appbar/custom_app_bar.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/widgets/sidebar/sidebar.dart';

import '../widgets/shifts/shift_day.dart';

Uuid owner = const Uuid();

class TimeSheetRoute extends StatelessWidget {
  TimeSheetRoute({super.key});

  final List<Shift> eventList = getMockShifts(owner);

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
            ShiftDay(
              date: DateTime.now(),
              events: eventList,
              startExpanded: true,
            ),
            ShiftDay(
                date: DateTime.parse("2023-09-14 00:00:00.000"),
                subTitle: "this is some shit ain't it",
                events: eventList),
            ShiftDay(
                date: DateTime.parse("2023-09-13 00:00:00.000"),
                events: eventList),
            ShiftDay(
                date: DateTime.parse("2023-09-12 00:00:00.000"),
                subTitle: "derpy derp",
                events: eventList),
          ],
        ),
      ),
    );
  }
}
