import 'package:healtether_clinic_app/data_layer/models/drug_model/drug_model.dart';
import 'package:healtether_clinic_app/data_layer/models/lab_tests/lab_tests.dart';
import 'package:healtether_clinic_app/data_layer/models/symptom_model/symptom.dart';
import 'package:healtether_clinic_app/data_layer/models/vitals_model.dart/vital.dart';

class PrescriptionReport {
  String? id;
  Prescriptions? prescriptions;
  Vital? vitals;
  DoctorId? doctorId;
  Clinic? clinic;
  String? doctorName;
  String? patientName;
  int? patientAge;
  String? patientGender;
  String? patientMobile;
  String? clinicPatientId;
  DateTime? appointmentDate;
  String? timeSlot;

  PrescriptionReport({
    this.id,
    this.prescriptions,
    this.vitals,
    this.doctorId,
    this.clinic,
    this.doctorName,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.patientMobile,
    this.clinicPatientId,
    this.appointmentDate,
    this.timeSlot,
  });

  factory PrescriptionReport.fromJson(Map<String, dynamic> json) => PrescriptionReport(
        id: json["_id"],
        prescriptions: json["prescriptions"] != null ? Prescriptions.fromJson(json["prescriptions"]) : null,
        vitals: json["vitals"] != null ? Vital.fromMap(json["vitals"]) : null,
        doctorId: json["doctorId"] != null ? DoctorId.fromJson(json["doctorId"]) : null,
        clinic: json["clinic"] != null ? Clinic.fromJson(json["clinic"]) : null,
        doctorName: json["doctorName"],
        patientName: json["patientName"],
        patientAge: json["patientAge"],
        patientGender: json["patientGender"],
        patientMobile: json["patientMobile"],
        clinicPatientId: json["clinicPatientId"],
        appointmentDate: DateTime.tryParse(json["appointmentDate"]),
        timeSlot: json["timeSlot"],
      );
}

class Clinic {
  String? id;
  String? address;
  String? clinicName;
  String? logo;
  AdminUserId? adminUserId;

  Clinic({
    this.id,
    this.address,
    this.clinicName,
    this.logo,
    this.adminUserId,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        id: json["_id"],
        address: json["address"],
        clinicName: json["clinicName"],
        logo: json["logo"],
        adminUserId: json["adminUserId"] != null ? AdminUserId.fromJson(json["adminUserId"]) : null,
      );
}

class AdminUserId {
  String? id;
  String? email;
  String? mobile;

  AdminUserId({
    this.id,
    this.email,
    this.mobile,
  });

  factory AdminUserId.fromJson(Map<String, dynamic> json) => AdminUserId(
        id: json["_id"],
        email: json["email"],
        mobile: json["mobile"],
      );
}

class DoctorId {
  String? id;
  String? specialization;

  DoctorId({
    this.id,
    this.specialization,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
        id: json["_id"],
        specialization: json["specialization"],
      );
}

class Prescriptions {
  String? id;
  List<Symptom>? symptoms;
  List<Symptom>? diagnosis;
  String? appointment;
  List<LabTest>? labTests;
  List<Drug>? drugPrescriptions;
  String? followUpDate;
  String? followUpTimeSlot;
  String? patientAdvice;
  String? privateNotes;

  Prescriptions({
    this.id,
    this.symptoms,
    this.diagnosis,
    this.appointment,
    this.labTests,
    this.drugPrescriptions,
    this.followUpDate,
    this.followUpTimeSlot,
    this.patientAdvice,
    this.privateNotes,
  });

  factory Prescriptions.fromJson(Map<String, dynamic> json) => Prescriptions(
        id: json["_id"],
        symptoms: json["symptoms"] != null ? List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromMap(x, 'Sx'))) : null,
        diagnosis: json["diagnosis"] != null ? List<Symptom>.from(json["diagnosis"].map((x) => Symptom.fromMap(x, 'Dx'))) : null,
        appointment: json["appointment"],
        labTests: json["labTests"] != null ? List<LabTest>.from(json["labTests"].map((x) => LabTest.fromMap(x))) : null,
        drugPrescriptions: json["drugPrescriptions"] != null ? List<Drug>.from(json["drugPrescriptions"].map((x) => Drug.fromMap(x))) : null,
        followUpDate: json["followUpDate"],
        followUpTimeSlot: json["followUpTimeSlot"],
        patientAdvice: json["patientAdvice"],
        privateNotes: json["privateNotes"],
      );
}
