// Package imports:
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'shift.dart';

class UserModel {
  UserModel(
    this.userId, {
    this.displayName,
    this.email,
    this.phone,
    this.created,
    this.modified,
    this.shifts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // insure ownerID is present
    if (!json.containsKey('userID')) {
      throw Exception('userID is missing from JSON data.');
    }

    return UserModel(json['userID'],
        displayName: json['displayName'],
        email: json['email'],
        phone: json['phone'],
        created: json['created'] ??
            json['start'] ??
            DateTime.now()
                .millisecondsSinceEpoch, // if created is null, use start, if start is null, use now
        modified: json['modified'],
        shifts: List<Shift>.from(json['shifts'] ?? <Shift>[]));
  }

  Uuid get getID => userId!;
  String get getDisplayName => displayName!;
  String get getEmail => email!;
  String get getPhone => phone!;
  DateTime? get getCreated => DateTime.parse(created!);
  DateTime? get getModified => DateTime.parse(modified!);

  Uuid? userId;
  String? displayName;
  String? email;
  String? phone;
  String? created;
  String? modified;
  List<Shift>? shifts;

  // get user as json string
  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'displayName': displayName,
        'email': email,
        'phone': phone,
        'created': created != null ? getCreated!.millisecondsSinceEpoch : null,
        'modified':
            modified != null ? getModified!.millisecondsSinceEpoch : null,
        'shifts': shifts != null
            ? shifts!.map((Shift e) => e.toJson()).toList()
            : null,
      };

  // Save the shift to the database
  Future<void> save() async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('/users/$userId');

    await ref.set(toJson()).then((void value) => null);
  }
}
