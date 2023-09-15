import 'dart:ffi';

class Shift {
  Uint16 ownerID;
  DateTime start;
  DateTime? end;
  DateTime? created;
  DateTime? updated;

  Shift({
    required this.ownerID,
    required this.start,
    this.end,
    this.created,
    this.updated,
  });

  Uint16 get getOwnerID => ownerID;
  DateTime get getStart => start;
  DateTime? get getEnd => end;
  DateTime? get getCreated => created;
  DateTime? get getUpdated => updated;

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      ownerID: json['ownerID'],
      start: DateTime.parse(json['start']),
      end: json['end'] != null ? DateTime.parse(json['end']) : null,
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      updated: json['updated'] != null ? DateTime.parse(json['updated']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'ownerID': ownerID,
        'start': start.toIso8601String(),
        'end': end != null ? end!.toIso8601String() : null,
        'created': created != null ? created!.toIso8601String() : null,
        'updated': updated != null ? updated!.toIso8601String() : null,
      };
}