// Package imports:
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class Shift {
  Shift(
    this.userId, {
    this.shiftID,
    this.startLocation,
    this.endLocation,
    this.start,
    this.end,
    this.created,
    this.updated,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    // insure ownerID is present
    if (!json.containsKey('ownerID')) {
      throw Exception('ownerID is missing from JSON data.');
    }

    return Shift(
      json['ownerID'],
      shiftID: json['shiftID'],
      startLocation: json['startLocation'] != null
          ? Position.fromMap(json['startLocation'])
          : null,
      endLocation: json['endLocation'] != null
          ? Position.fromMap(json['endLocation'])
          : null,
      start: json['start'],
      end: json['end'],
      created: json['created'] ?? DateTime.now().millisecondsSinceEpoch,
      updated: json['updated'],
    );
  }

  Uuid userId;
  Uuid? shiftID;
  Position? startLocation;
  Position? endLocation;
  int? start;
  int? end;
  int? created;
  int? updated;

  Uuid get getOwnerID => userId;
  DateTime? get getStart =>
      DateTime.fromMillisecondsSinceEpoch(start!, isUtc: true);
  DateTime? get getEnd =>
      DateTime.fromMillisecondsSinceEpoch(end!, isUtc: true);
  DateTime? get getCreated =>
      DateTime.fromMillisecondsSinceEpoch(created!, isUtc: true);
  DateTime? get getUpdated =>
      DateTime.fromMillisecondsSinceEpoch(updated!, isUtc: true);
  Position? get getStartLocation => startLocation;
  Position? get getEndLocation => endLocation;

  String getStartTimeString() {
    if (start == null) {
      return '';
    }
    final int actualHour =
        getStart!.hour > 12 ? getStart!.hour - 12 : getStart!.hour;
    final String h = actualHour.toString().padLeft(2, '0');
    final String m = getStart!.minute.toString().padLeft(2, '0');
    final String a = getStart!.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $a';
  }

  String getEndTimeString() {
    if (end == null) {
      return '';
    }
    final int actualHour = getEnd!.hour > 12 ? getEnd!.hour - 12 : getEnd!.hour;
    final String h = actualHour.toString().padLeft(2, '0');
    final String m = getEnd!.minute.toString().padLeft(2, '0');
    final String a = getEnd!.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $a';
  }

  /// Get the duration of the shift
  Duration getDuration() {
    if (start == null || end == null) {
      return const Duration();
    }

    return getEnd!.difference(getStart!);
  }

  /// Get the duration of the shift as a json string
  Map<String, dynamic> toJson() => <String, dynamic>{
        'ownerID': userId.toString(),
        'start': start != null ? getStart!.millisecondsSinceEpoch : null,
        'end': end != null ? getEnd!.millisecondsSinceEpoch : null,
        'startLocation': startLocation != null ? startLocation!.toJson() : null,
        'endLocation': endLocation != null ? endLocation!.toJson() : null,
        'created': created != null ? getCreated!.millisecondsSinceEpoch : null,
        'updated': updated != null ? getUpdated!.millisecondsSinceEpoch : null,
      };

  // Save the shift to the database
  Future<void> save() async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('/users/$userId/shifts');

    await ref.set(toJson()).then((void value) => null);
  }
}
