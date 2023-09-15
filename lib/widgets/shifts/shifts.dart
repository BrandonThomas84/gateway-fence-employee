import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/util/log.dart';

import 'shift_day.dart';

class Shifts extends StatelessWidget {
  final List<Shift> eventList;

  const Shifts({super.key, required this.eventList});

  // group the events by date
  Map<int, List<Shift>> _sorted(List<Shift> events) {
    Map<int, List<Shift>> map = {};

    // loop through the events and group them by date
    for (Shift event in events) {
      // skip events that don't have a start date
      if (event.start == null) {
        Logger.debug(
            "event start is null, will not be included in shifts output",
            data: {"event": event.toJson()});
        continue;
      }

      // create a date object from the event
      DateTime d = DateTime.parse(event.start!);

      // create a key
      int key = int.parse("${d.year}${d.month}${d.day}");

      if (map.containsKey(key)) {
        map[key]!.add(event);
      } else {
        map[key] = [event];
      }
    }

    // sort the resulting map and return
    return Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (MapEntry<int, List<Shift>> entry in _sorted(eventList).entries)
          ShiftDay(
            startExpanded: entry.key == _sorted(eventList).keys.first,
            date: DateTime.parse(entry.value[0].start!),
            shifts: entry.value,
          ),
      ],
    );
  }
}
