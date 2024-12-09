import 'package:healtether_clinic_app/data_layer/models/patient_records_model/appointments_model.dart';

class PatientOverviewModel {
  String? id;
  String? sId;
  String? patientId;
  String? firstName;
  String? lastName;
  String? mobile;
  int? age;
  String? gender;
  List<Appointments>? appointments;

  PatientOverviewModel({
    this.id,
    this.sId,
    this.patientId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.age,
    this.gender,
    this.appointments,
  });

  String get fullName => "${firstName ?? ' '}${lastName != null ? " $lastName" : ""}";

  String get initials => fullName.split(' ').map((e) => e.isEmpty ? '' : e[0].toUpperCase()).join('');

  PatientOverviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    age = json['age'] as int;
    gender = json['gender'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['_id'] = sId;
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }

    return data;
  }*/
}
