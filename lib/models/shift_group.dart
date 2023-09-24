// Project imports:
import 'package:gateway_fence_employee/util/time.dart';
import 'shift.dart';

/// A class that groups shifts by date
class ShiftGroup {
  List<Shift> shifts;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _totalHours;
  Map<int, List<Shift>>? _sorted;

  /// Creates a new ShiftGroup
  ShiftGroup(this.shifts);

  /// Returns the start date of the first shift in the list
  DateTime getStartDate() {
    if (_startDate != null) return _startDate!;

    int earliestDate = DateTime.now().millisecondsSinceEpoch;

    for (Shift shift in shifts) {
      if (shift.start == null) {
        continue;
      }

      if (shift.start! < earliestDate) {
        earliestDate = shift.start!;
      }
    }

    _startDate = DateTime.fromMillisecondsSinceEpoch(earliestDate, isUtc: true);

    return _startDate!;
  }

  /// Returns the end date of the last shift in the list
  DateTime getEndDate() {
    if (_endDate != null) return _endDate!;

    int latestDate = DateTime(1970).millisecondsSinceEpoch;

    for (Shift shift in shifts) {
      if (shift.end == null) {
        continue;
      }

      if (shift.end! > latestDate) {
        latestDate = shift.end!;
      }
    }

    _endDate = DateTime.fromMillisecondsSinceEpoch(latestDate);

    return _endDate!;
  }

  /// Returns the total hours worked in the list
  String getTotalHours() {
    if (_totalHours != null) return _totalHours!;

    double totalHours = 0;

    for (Shift shift in shifts) {
      // make sure we have a start and end time
      if (shift.start == null || shift.end == null) {
        continue;
      }

      // count the milliseconds between the two times
      int milliseconds = shift.end! - shift.start!;

      //  convert to minutes
      totalHours += (milliseconds / 1000 / 60 / 30);
    }

    _totalHours = totalHours.toStringAsPrecision(4);

    return _totalHours!;
  }

  /// Returns a map of shifts grouped by date, the set will be ordered descending by date
  Map<int, List<Shift>> getSorted() {
    if (_sorted != null) return _sorted!;

    Map<int, List<Shift>> map = {};

    // loop through the events and group them by date
    for (Shift shift in shifts) {
      // skip events that don't have a start date
      if (shift.start == null) {
        continue;
      }

      // create a date object from the event
      DateTime? d =
          DateTime.fromMillisecondsSinceEpoch(shift.start!, isUtc: true);

      // create a key
      int key = int.parse(
          '${padd0(d.year.toString())}${padd0(d.month.toString())}${padd0(d.day.toString())}');

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
