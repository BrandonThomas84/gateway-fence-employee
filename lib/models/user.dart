// Package imports:
import 'package:firebase_database/firebase_database.dart';

class UserModel {
  UserModel(
    this.userId, {
    this.displayName,
    this.email,
    this.phone,
    this.created,
    this.modified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // insure ownerID is present
    if (!json.containsKey('userId')) {
      throw Exception('userId is missing from JSON data.');
    }

    return UserModel(
      json['userId'],
      displayName: json['displayName'],
      email: json['email'],
      phone: json['phone'],
      created: json['created'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      modified: json['modified'],
    );
  }

  String get getID => userId;
  String get getDisplayName => displayName!;
  String get getEmail => email!;
  String get getPhone => phone!;
  DateTime get getCreated =>
      created == null ? DateTime.now() : DateTime.parse(created!);
  DateTime? get getModified =>
      modified == null ? null : DateTime.parse(modified!);

  String userId;
  String? displayName;
  String? email;
  String? phone;
  String? created;
  String? modified;

  Future<void> save() async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/$userId');
    return await ref.set(toJson());
  }

  // get user as json string
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'created': created != null ? getCreated.millisecondsSinceEpoch.toString() : null,
      'modified': modified != null ? getModified!.millisecondsSinceEpoch.toString() : null,
    };
  }
}
