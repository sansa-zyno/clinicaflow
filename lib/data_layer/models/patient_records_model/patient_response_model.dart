import 'package:healtether_clinic_app/data_layer/models/patient_records_model/patient_model.dart';

class PatientResponse {
  List<PatientOverviewModel>? data;
  int? totalCount;

  PatientResponse({this.data, this.totalCount});

  PatientResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PatientOverviewModel>[];
      json['data'].forEach((v) {
        data!.add(PatientOverviewModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }*/
}
