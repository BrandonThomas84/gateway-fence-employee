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
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                right: 30,
                bottom: 30,
                left: 30,
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time Sheet",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date Ranges:",
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                      Text(
                        "09/12/2021 - 09/14/2021",
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Hours:",
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                      Text(
                        "24.5",
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
