import 'package:flutter/material.dart';

import 'shift.dart';
import 'shift_day.dart';

class ShiftList extends StatelessWidget {
  const ShiftList({
    super.key,
    required this.eventList,
  });

  /// the list of events that will be displayed
  final List<Shift> eventList;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
