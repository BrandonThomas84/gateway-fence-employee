import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import 'shift.dart';

class User {
  Uuid? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? created;
  String? modified;
  List<Shift>? shifts;

  User(
    this.userId, {
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.created,
    this.modified,
    this.shifts,
  });

  Uuid get getID => userId!;
  String get getFirstName => firstName!;
  String get getLastName => lastName!;
  String get getEmail => email!;
  String get getPhone => phone!;
  DateTime? get getCreated => DateTime.parse(created!);
  DateTime? get getModified => DateTime.parse(modified!);

  factory User.fromJson(Map<String, dynamic> json) {
    // insure ownerID is present
    if (!json.containsKey('userID')) {
      throw Exception('userID is missing from JSON data.');
    }

    return User(json['userID'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phone: json['phone'],
        created: json['created'] ??
            json['start'] ??
            DateTime.now()
                .toIso8601String(), // if created is null, use start, if start is null, use now
        modified: json['modified'],
        shifts: List.castFrom(json['shifts']));
  }

  // get user as json string
  Map<String, dynamic> toJson() => {
        'userID': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'created': created != null ? getCreated!.toIso8601String() : null,
        'modified': modified != null ? getModified!.toIso8601String() : null,
        'shifts':
            shifts != null ? shifts!.map((e) => e.toJson()).toList() : null,
      };

  // Save the shift to the database
  Future<void> save() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('/users/$userId');

    await ref.set(toJson()).then((value) => null);
  }
}
