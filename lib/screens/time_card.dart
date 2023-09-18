import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/models/shift_group.dart';
import 'package:gateway_fence_employee/screens/_util.dart';
import 'package:gateway_fence_employee/util/mocks/shifts.dart';
import 'package:gateway_fence_employee/widgets/shifts/shift_day.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/models/shift.dart';

import '../util/time.dart';

Uuid owner = const Uuid();

GoRoute timeCardScreenGoRoute = GoRoute(
  path: '/time-card',
  builder: (context, state) => const TimeCardScreen(),
);

class TimeCardScreen extends StatefulWidget {
  const TimeCardScreen({super.key});

  @override
  State<TimeCardScreen> createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  final List<Shift> shiftList = getMockShifts(owner, workingDays: 5);
  late ShiftGroup shiftGroup = ShiftGroup(shiftList);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String startDate = padd0(shiftGroup.getStartDate().day.toString());
    String startMonth = padd0(shiftGroup.getStartDate().month.toString());
    String startYear = shiftGroup.getStartDate().year.toString();
    String endDate = padd0(shiftGroup.getLastDate().day.toString());
    String endMonth = padd0(shiftGroup.getLastDate().month.toString());
    String endYear = shiftGroup.getLastDate().year.toString();
    String totalHours = shiftGroup.getTotalHours().toStringAsFixed(2);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Date Ranges:",
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    "$startMonth/$startDate/$startYear - $endMonth/$endDate/$endYear",
                    style: const TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Hours:",
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    totalHours,
                    style: const TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        for (MapEntry<int, List<Shift>> entry in shiftGroup.getSorted().entries)
          ShiftDay(
            startExpanded: entry.key == shiftGroup.getSorted().keys.first,
            date: DateTime.parse(entry.value[0].start!),
            shifts: entry.value,
          ),
      ],
    );
  }
}
