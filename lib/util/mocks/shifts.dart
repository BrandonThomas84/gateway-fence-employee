import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/util/time.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

List<Shift> getMockShifts(Uuid owner, {int workingDays = 10}) {
  List<Shift> shifts = [];

  // set a current date to midnight so we can go back in time
  DateTime now = DateTime.now();

  for (var i = 0; i < workingDays; i++) {
    DateTime activeDay = now.subtract(Duration(days: i));

    String year = padd0(activeDay.year.toString());
    String month = padd0(activeDay.month.toString());
    String day = padd0(activeDay.day.toString());

    DateTime firstShiftStart = DateTime.parse(
        "$year-$month-$day 00:${padd0(getRandomInt(1, 59).toString())}:00");
    DateTime firstShiftEnd = DateTime.parse(
        "$year-$month-$day 05:${padd0(getRandomInt(1, 59).toString())}:00");

    // add a morning shift
    shifts.add(
      Shift(
        owner,
        start: firstShiftStart.millisecondsSinceEpoch,
        end: firstShiftEnd.millisecondsSinceEpoch,
        startLocation: Position(
            longitude: 39.2191,
            latitude: -121.0611,
            timestamp: firstShiftStart,
            accuracy: 0.0,
            altitude: 760,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0),
        endLocation: Position(
            longitude: 39.2191,
            latitude: -121.0611,
            timestamp: firstShiftEnd,
            accuracy: 0.0,
            altitude: 760,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0),
      ),
    );

    // if just today then don't add any more time
    if (i == 0) {
      continue;
    }

    DateTime secondShiftStart = DateTime.parse(
        "$year-$month-$day 06:${padd0(getRandomInt(1, 59).toString())}:00");
    DateTime secondShiftEnd = DateTime.parse(
        "$year-$month-$day 11:${padd0(getRandomInt(1, 59).toString())}:00");

    // add lunch shift
    shifts.add(
      Shift(
        owner,
        start: secondShiftStart.millisecondsSinceEpoch,
        end: secondShiftEnd.millisecondsSinceEpoch,
        startLocation: Position(
            longitude: 39.2191,
            latitude: -121.0611,
            timestamp: secondShiftStart,
            accuracy: 0.0,
            altitude: 760,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0),
        endLocation: Position(
            longitude: 39.2191,
            latitude: -121.0611,
            timestamp: secondShiftEnd,
            accuracy: 0.0,
            altitude: 760,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0),
      ),
    );
  }

  return shifts;
}
