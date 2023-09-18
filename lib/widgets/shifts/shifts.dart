import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/time.dart';

import 'shift_day.dart';

class Shifts extends StatelessWidget {
  final List<Shift> eventList;

  const Shifts({super.key, required this.eventList});

  // group the events by date
  Map<int, List<Shift>> _sorted(List<Shift> shitfts) {
    Map<int, List<Shift>> map = {};

    // loop through the events and group them by date
    for (Shift shift in shitfts) {
      // skip events that don't have a start date
      if (shift.start == null) {
        Logger.debug(
            "event start is null, will not be included in shifts output",
            data: {"event": shift.toJson()});
        continue;
      }

      // create a date object from the event
      DateTime? d = DateTime.tryParse(shift.start!);
      if (d == null) {
        Logger.debug(
            "event start is not a valid date, will not be included in shifts output",
            data: {"event": shift.toJson()});
        continue;
      }

      // create a key
      int key = int.parse(
          "${padd0(d.year.toString())}${padd0(d.month.toString())}${padd0(d.day.toString())}");

      // create the list if the key doesn't exist
      if (!map.containsKey(key)) {
        map[key] = [];
      }

      // add the shift to the list
      map[key]!.add(shift);
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
