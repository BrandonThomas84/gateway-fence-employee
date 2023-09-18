import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/time.dart';

import 'shift.dart';

class ShiftGroup {
  List<Shift> shifts;
  DateTime? _startDate;
  DateTime? _lastDate;
  double? _totalHours;
  Map<int, List<Shift>>? _sorted;

  ShiftGroup(this.shifts);

  DateTime getStartDate() {
    if (_startDate != null) return _startDate!;

    DateTime earliestDate = DateTime.now();

    for (Shift shift in shifts) {
      DateTime? d = DateTime.tryParse(shift.start!);

      if (d == null) {
        Logger.error("failed to parse date: ${shift.start}");
        continue;
      }

      if (d.isBefore(earliestDate)) {
        earliestDate = d;
      }
    }

    _startDate = earliestDate;

    return _startDate!;
  }

  DateTime getLastDate() {
    if (_lastDate != null) return _lastDate!;

    DateTime latestDate = DateTime(1970);

    for (Shift shift in shifts) {
      DateTime? d = DateTime.tryParse(shift.end!);

      if (d == null) {
        Logger.error("failed to parse date: ${shift.end}");
        continue;
      }

      if (d.isAfter(latestDate)) {
        latestDate = d;
      }
    }

    _lastDate = latestDate;

    return _lastDate!;
  }

  double getTotalHours() {
    if (_totalHours != null) return _totalHours!;

    double totalHours = 0;

    for (Shift shift in shifts) {
      DateTime? start = DateTime.tryParse(shift.start!);
      DateTime? end = DateTime.tryParse(shift.end!);

      if (start == null || end == null) {
        Logger.error("failed to parse date: ${shift.start} or ${shift.end}");
        continue;
      }

      totalHours += end.difference(start).inMinutes / 60;
    }

    _totalHours = totalHours;

    return _totalHours!;
  }

  Map<int, List<Shift>> getSorted() {
    if (_sorted != null) return _sorted!;

    Map<int, List<Shift>> map = {};

    // loop through the events and group them by date
    for (Shift shift in shifts) {
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

    _sorted = Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

    // sort the resulting map and return
    return _sorted!;
  }
}
