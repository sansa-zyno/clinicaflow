import 'dart:convert';
import 'package:healtether_clinic_app/utils/mixins/time_parser_mixin.dart';

class AppointmentModel {
  List<Appointment>? data;
  int? totalCount;

  AppointmentModel({this.data, this.totalCount});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Appointment>[];
      json['data'].forEach((v) {
        data!.add(Appointment.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class Appointment {
  final String? sId;
  final String? mobile;
  final String? name;
  final String? appointmentDate;
  final String? timeSlot;
  final bool? virtualConsultation;
  final String? doctorName;
  final String? patientId;
  final String? id;
  final List<AppointmentLog>? appointmentLogs;
  final int? age;
  final String? gender;

  String? get getPatientId => patientId?.substring(patientId!.length - 6);

  const Appointment(
      {this.sId,
      this.mobile,
      this.name,
      this.appointmentDate,
      this.timeSlot,
      this.virtualConsultation,
      this.doctorName,
      this.patientId,
      this.appointmentLogs,
      this.age,
      this.gender,
      this.id});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        sId: json['_id'],
        mobile: json['mobile'],
        name: json['name'],
        appointmentDate: json['appointmentDate'],
        timeSlot: json['timeSlot'],
        virtualConsultation: json['virtualConsultation'],
        doctorName: json['doctorName'],
        patientId: json['patientId'],
        appointmentLogs: json["appointmentLogs"],
        age: json['age'],
        gender: json['gender'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobile'] = mobile;
    data['name'] = name;
    data['appointmentDate'] = appointmentDate;
    data['timeSlot'] = timeSlot;
    data['virtualConsultation'] = virtualConsultation;
    data['doctorName'] = doctorName;
    data['patientId'] = patientId;
    data['id'] = id;
    return data;
  }
}

class AppointmentLog with TimeParserMixin {
  final String _time;
  final String message;
  AppointmentLog({
    required String time,
    required this.message,
  }) : _time = time;

  String get time => formatTimeStamp(_time);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': _time,
      'message': message,
    };
  }

  factory AppointmentLog.fromMap(Map<String, dynamic> map) {
    return AppointmentLog(
      time: map['time'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentLog.fromJson(String source) =>
      AppointmentLog.fromMap(json.decode(source) as Map<String, dynamic>);
}
