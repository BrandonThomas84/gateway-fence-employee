// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/models/shift_group.dart';
import 'package:gateway_fence_employee/util/shifts.dart';
import 'package:gateway_fence_employee/util/time.dart';
import 'package:gateway_fence_employee/widgets/shifts/shift_day.dart';
import 'default_screen_scaffold.dart';

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
    String startDate = prettyDate(shiftGroup.getStartDate(), false);
    String endDate = prettyDate(shiftGroup.getEndDate(), false);

    return DefaultScreenScaffold(
      title: 'Time Card',
      scaffoldKey: GlobalKey<ScaffoldState>(),
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
                    'Start:',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    startDate,
                    style: const TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'End:',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    endDate,
                    style: const TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Hours:',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                  Text(
                    shiftGroup.getTotalHours(),
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
            date: DateTime.fromMillisecondsSinceEpoch(entry.value[0].start!),
            shifts: entry.value,
          ),
      ],
    );
  }
}
