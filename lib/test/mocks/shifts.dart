import 'package:gateway_fence_employee/models/shift.dart';
import 'package:uuid/uuid.dart';

List<Shift> getMockShifts(Uuid owner, {int workingDays = 10}) {
  List<Shift> shifts = [];

  // set a current date to midnight so we can go back in time
  DateTime now = DateTime.now();

  for (var i = 0; i < workingDays; i++) {
    String year = now.year.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String day = (now.day - i).toString().padLeft(2, '0');
    String min = i > 59 ? "00" : i.toString().padLeft(2, '0');

    // add a morning shift
    shifts.add(
      Shift(
        owner,
        start: "$year-$month-$day 07:59:$min",
        end: "$year-$month-$day 12:02:$min",
      ),
    );

    // if just today then don't add any more time
    if (i == 0) {
      continue;
    }

    // add lunch shift
    shifts.add(
      Shift(
        owner,
        start: "$year-$month-$day 13:01:$min",
        end: "$year-$month-$day 17:35:$min",
      ),
    );
  }

  return shifts;
}
