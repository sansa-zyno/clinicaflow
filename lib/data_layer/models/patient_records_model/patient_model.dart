import 'package:healtether_clinic_app/data_layer/models/patient_records_model/appointments_model.dart';

class PatientOverviewModel {
  String? sId;
  String? patientId;
  String? firstName;
  String? lastName;
  String? mobile;
  List<Appointments>? appointments;
  String? id;

  PatientOverviewModel(
      {this.sId,
      this.patientId,
      this.firstName,
      this.lastName,
      this.mobile,
      this.appointments,
      this.id});

  String get fullName =>
      "${lastName ?? ''}${firstName != null ? " $firstName" : ""}";

  String get initials =>
      fullName.split(' ').map((e) => e[0].toUpperCase()).join('');

  PatientOverviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointments.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}
