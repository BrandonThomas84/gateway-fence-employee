import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class Shift {
  Uuid userId;
  Uuid? shiftID;
  String? start;
  String? end;
  String? created;
  String? updated;

  Shift(
    this.userId, {
    this.start,
    this.end,
    this.created,
    this.updated,
    this.shiftID,
  });

  Uuid get getOwnerID => userId;
  DateTime? get getStart => DateTime.parse(start!);
  DateTime? get getEnd => DateTime.parse(end!);
  DateTime? get getCreated => DateTime.parse(created!);
  DateTime? get getUpdated => DateTime.parse(updated!);

  factory Shift.fromJson(Map<String, dynamic> json) {
    // insure ownerID is present
    if (!json.containsKey('ownerID')) {
      throw Exception('ownerID is missing from JSON data.');
    }

    return Shift(
      json['ownerID'],
      shiftID: json['shiftID'],
      start: json['start'],
      end: json['end'],
      created: json['created'] ??
          json['start'] ??
          DateTime.now()
              .toIso8601String(), // if created is null, use start, if start is null, use now
      updated: json['updated'],
    );
  }

  /// Get the duration of the shift as a string
  String getDurationString() {
    if (start == null || end == null) return "";

    final Duration duration = getEnd!.difference(getStart!);

    return "${duration.inHours}h ${duration.inMinutes.remainder(60)}m";
  }

  /// Get the duration of the shift as a json string
  Map<String, dynamic> toJson() => {
        'ownerID': userId,
        'start': start != null ? getStart!.toIso8601String() : null,
        'end': end != null ? getEnd!.toIso8601String() : null,
        'created': created != null ? getCreated!.toIso8601String() : null,
        'updated': updated != null ? getUpdated!.toIso8601String() : null,
      };

  // Save the shift to the database
  Future<void> save() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("/users/$userId/shifts");

    await ref.set(toJson()).then((value) => null);
  }
}
