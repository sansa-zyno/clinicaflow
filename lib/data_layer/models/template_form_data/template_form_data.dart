// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:healtether_clinic_app/data_layer/models/appointment_slot/appointment_slot.dart';
import 'package:healtether_clinic_app/utils/enums/enums.dart';

class TemplateFormData {
  final String? clinicLogo;
  final String? doctorName;
  final String? doctorSpecialty;
  final String? otherInfo;
  final String? clinicAddress;
  final List<String> clinicContacts;
  final List<String> clinicEmails;
  final PrescriptionTemplates template;
  final List<AppointmentSlot> openHours; // = [AppointmentSlot(days: [], timeSlot: TimeSlot(const Uuid().v4()))];
  Map<String, bool>? autofill = {
    "Patient Id": false,
    "Patient Personal details - Name, contact": false,
    "Patient Vitals details": false,
    "Patient Past history details": false,
    "Symptoms and Diagnosis": false,
    "Lab Tests": false,
    "Drug prescription": false,
  };
  TemplateFormData({
    required this.template,
    this.autofill,
    this.clinicLogo,
    this.doctorName,
    this.doctorSpecialty,
    this.otherInfo,
    this.clinicAddress,
    this.clinicContacts = const [''],
    this.clinicEmails = const [''],
    this.openHours = const []
  });

  bool get isValid {
    return doctorName != null &&
        doctorSpecialty != null &&
        clinicAddress != null &&
        clinicContacts.where((e) => e.isNotEmpty).isNotEmpty == true &&
        clinicEmails.where((e) => e.isNotEmpty).isNotEmpty == true;
  }

  TemplateFormData copyWith(
      {String? clinicLogo,
      String? doctorName,
      String? doctorSpecialty,
      String? otherInfo,
      String? clinicAddress,
      List<String>? clinicContacts,
      List<String>? clinicEmails,
      List<AppointmentSlot>? openHours,
      Map<String, bool>? autofill}) {
    return TemplateFormData(
      template: template,
      autofill: autofill ?? this.autofill,
      clinicLogo: clinicLogo ?? this.clinicLogo,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      otherInfo: otherInfo ?? this.otherInfo,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      clinicContacts: clinicContacts ?? this.clinicContacts,
      clinicEmails: clinicEmails ?? this.clinicEmails,
      openHours: openHours ?? this.openHours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'template': template.describe,
      'autofill': autofill,
      'clinicLogo': clinicLogo,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'otherInfo': otherInfo,
      'clinicAddress': clinicAddress,
      'clinicContacts': clinicContacts,
      'clinicEmails': clinicEmails,
    };
  }

  factory TemplateFormData.fromMap(Map<String, dynamic> map) {
    return TemplateFormData(
      template: PrescriptionTemplates.fromString(map['template'] as String),
      clinicLogo:
          map['clinicLogo'] != null ? map['clinicLogo'] as String : null,
      doctorName:
          map['doctorName'] != null ? map['doctorName'] as String : null,
      doctorSpecialty: map['doctorSpecialty'] != null
          ? map['doctorSpecialty'] as String
          : null,
      otherInfo: map['otherInfo'] != null ? map['otherInfo'] as String : null,
      clinicAddress:
          map['clinicAddress'] != null ? map['clinicAddress'] as String : null,
      clinicContacts: map['clinicContacts'] as List<String>,
      clinicEmails: map['clinicEmails'] as List<String>,
      openHours: (map['openHours'] as List<Map<String, dynamic>>).map((e) => AppointmentSlot.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'TemplateFormData(clinicLogo: $clinicLogo, doctorName: $doctorName, doctorSpecialty: $doctorSpecialty, otherInfo: $otherInfo, clinicAddress: $clinicAddress, clinicContacts: $clinicContacts, clinicEmails: $clinicEmails, template: $template)';
  }

  @override
  bool operator ==(covariant TemplateFormData other) {
    if (identical(this, other)) return true;
  
    return other.template == template;
  }

  @override
  int get hashCode {
    return template.hashCode;
  }
}
