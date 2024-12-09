import 'dart:convert';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePic;
  final String? email;
  final String? specialization;
  final bool isSuperAdmin;
  final bool isDoctor;
  final List<dynamic> linkedClinics;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    this.email,
    this.specialization,
    required this.isSuperAdmin,
    required this.isDoctor,
    required this.linkedClinics,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       id: json["id"],
  //       firstName: json["firstName"],
  //       lastName: json["lastName"],
  //       email: json["email"],
  //       isSuperAdmin: json["isSuperAdmin"],
  //       linkedClinics:
  //           List<dynamic>.from(json["linkedClinics"].map((x) => x) ?? []),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "firstName": firstName,
  //       "lastName": lastName,
  //       "email": email,
  //       "isSuperAdmin": isSuperAdmin,
  //       "linkedClinics": List<dynamic>.from(linkedClinics.map((x) => x)),
  //     };

  /* @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, isSuperAdmin: $isSuperAdmin, linkedClinics: $linkedClinics)';
  }*/

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profilePic': profilePic,
      'email': email,
      'specialization': specialization,
      'isSuperAdmin': isSuperAdmin,
      'isDoctor': isDoctor,
      'linkedClinics': linkedClinics,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      profilePic: map['profilePic'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      specialization: map['specialization'] != null ? map['specialization'] as String : null,
      isSuperAdmin: map['isSuperAdmin'] as bool,
      isDoctor: map['isDoctor'] as bool,
      linkedClinics: List<dynamic>.from((map['linkedClinics'] as List<dynamic>)),
    );
  }

  static Future<UserModel?> getCurrentUser() async {
    final userJson = await SharedPrefService.getUser();
    return userJson != null ? UserModel.fromJson(userJson) : null;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
