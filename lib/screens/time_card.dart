import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/screens/_util.dart';
import 'package:gateway_fence_employee/util/mocks/shifts.dart';
import 'package:gateway_fence_employee/widgets/shifts/shifts.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/models/shift.dart';

Uuid owner = const Uuid();

GoRoute timeCardScreenGoRoute = GoRoute(
  path: '/time-card',
  builder: (context, state) => TimeCardScreen(),
);

class TimeCardScreen extends StatelessWidget {
  TimeCardScreen({super.key});

  final List<Shift> eventList = getMockShifts(owner, workingDays: 25);

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: "Time Card",
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        Shifts(eventList: eventList),
      ],
    );
  }
}
