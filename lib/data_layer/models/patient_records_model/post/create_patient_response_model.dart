import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/patient_create_model.dart';

class CreatePatientResponse {
  PatientCreate? patientCreate;

  CreatePatientResponse({this.patientCreate});

  CreatePatientResponse.fromJson(Map<String, dynamic> json) {
    patientCreate = json['patientCreate'] != null
        ? PatientCreate.fromJson(json['patientCreate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patientCreate != null) {
      data['patientData'] = patientCreate!.toJson();
    }
    return data;
  }
}






