import 'shift.dart';

class ShiftGroups {
  List<Shift> shifts;

  ShiftGroups({this.shifts = const []});

  /// Add a new shift to the list
  void add(Shift shift) {
    shifts.add(shift);
  }

  /// Remove a shift from the list
  void remove(Shift shift) {
    shifts.remove(shift);
  }

  /// Remove a shift from the list by index
  void removeAt(int index) {
    shifts.removeAt(index);
  }

  /// Get a shift by index
  Shift get(int index) {
    return shifts[index];
  }

  /// Get the length of the list
  int get length {
    return shifts.length;
  }

  factory ShiftGroups.fromJson(Map<String, dynamic> json) {
    return ShiftGroups(
      shifts: List<Shift>.from(json['shifts'].map((x) => Shift.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'shifts': List<dynamic>.from(shifts.map((x) => x.toJson())),
      };
}
