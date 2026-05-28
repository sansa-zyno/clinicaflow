import 'package:clinica_flow/shared/models/document_model.dart';

import '../../../shared/models/address_model.dart';
import '../../../shared/models/created_model.dart';
import '../../appointment/model/appointment_model.dart';

class PatientModel {
  PatientModel(
      {this.id,
      this.patientId,
      this.profilepic,
      this.firstName,
      this.lastName,
      this.age,
      this.height,
      this.weight,
      this.birthday,
      this.gender,
      this.mobile,
      this.email,
      this.address,
      this.documentType,
      this.documentNumber,
      this.documents,
      this.appointments,
      this.createdOn,
      this.modifiedOn,
      this.clientId});

  String? id;
  String? patientId;
  String? profilepic;
  String? firstName;
  String? lastName;
  int? age;
  int? height;
  int? weight;
  DateTime? birthday;
  String? gender;
  String? mobile;
  String? email;
  Address? address;
  String? documentType;
  String? documentNumber;
  List<Documents>? documents;
  List<Appointment>? appointments;
  Created? createdOn;
  Created? modifiedOn;
  String? clientId;

  PatientModel copyWith(
      {String? id,
      String? patientId,
      String? profilepic,
      String? firstName,
      String? lastName,
      int? age,
      int? height,
      int? weight,
      DateTime? birthday,
      String? gender,
      String? mobile,
      String? email,
      Address? address,
      String? documentType,
      String? documentNumber,
      List<Documents>? documents,
      List<Appointment>? appointments,
      Created? createdOn,
      Created? modifiedOn,
      String? clientId}) {
    return PatientModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      profilepic: profilepic ?? this.profilepic,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      documents: documents ?? this.documents,
      appointments: appointments ?? this.appointments,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      clientId: clientId ?? this.clientId,
    );
  }

  String get fullName =>
      "${firstName ?? ' '}${lastName != null ? " $lastName" : ""}";

  String get initials => fullName
      .split(' ')
      .map((e) => e.isEmpty ? '' : e[0].toUpperCase())
      .join('');

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json["id"] ?? "",
      patientId: json["patientId"] ?? "",
      profilepic: json["profilepic"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      age: json["age"] ?? 0,
      height: json["height"] ?? 0,
      weight: json["weight"] ?? 0,
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      gender: json["gender"] ?? "",
      mobile: json["mobile"] ?? "",
      email: json["email"] ?? "",
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      documentType: json["documentType"] ?? "",
      documentNumber: json["documentNumber"] ?? "",
      documents: json["documents"] == null
          ? []
          : List<Documents>.from(
              json["documents"]!.map((x) => Documents.fromJson(x))),
      appointments: json["appointments"] == null
          ? []
          : List<Appointment>.from(
              json["appointments"]!.map((x) => Appointment.fromJson(x))),
      createdOn: json["createdOn"] == null
          ? null
          : Created.fromJson(json["createdOn"]),
      modifiedOn: json["modifiedOn"] == null
          ? null
          : Created.fromJson(json["modifiedOn"]),
      clientId: json["clientId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        'profilepic': profilepic,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "height": height,
        "weight": weight,
        "birthday": birthday?.toIso8601String(),
        "gender": gender,
        "mobile": mobile,
        "email": email,
        "address": address != null ? address?.toJson() : Address().toJson(),
        "documentType": documentType,
        "documentNumber": documentNumber,
        "documents":
            documents != null ? documents!.map((x) => x.toJson()).toList() : [],
        'appointments': appointments != null
            ? appointments!.map((x) => x.toJson()).toList()
            : [],
        'createdOn': createdOn?.toJson(),
        'modifiedOn': modifiedOn?.toJson(),
        'clientId': clientId,
      };

  @override
  String toString() {
    return "$id,$patientId, $profilepic, $firstName, $lastName, $age, $height, $weight, $birthday, $gender, $mobile, $email,$address, $documentType, $documentNumber, $documents, $appointments, $createdOn, $modifiedOn, $clientId ";
  }
}
