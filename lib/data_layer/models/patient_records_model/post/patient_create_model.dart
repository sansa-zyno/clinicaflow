import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/address_patient_model.dart';
import 'package:healtether_clinic_app/data_layer/models/patient_records_model/post/documents_patient_model.dart';

class PatientCreate {
  String? firstName;
  String? lastName;
  String? patientId;
  String? age;
  String? height;
  String? weight;
  String? birthday;
  String? gender;
  String? mobile;
  String? email;
  AddressPatient? address;
  String? documentType;
  String? documentNumber;
  List<DocumentsPatient>? documents;
  String? createdOn;
  String? modifiedOn;
  String? clientId;

  PatientCreate(
      {this.firstName,
      this.lastName,
      this.patientId,
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
      this.createdOn,
      this.modifiedOn,
      this.clientId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['age'] = int.parse(age ?? "0");
    data['height'] = int.parse(height ?? "0");
    data['weight'] = int.parse(weight ?? "0");
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['email'] = email ?? "";
    if (address != null) {
      data['address'] = address!.toJson();
    } else {
      data['address'] = AddressPatient().toJson();
    }
    data['documentType'] = documentType ?? "";
    data['documentNumber'] = documentNumber ?? "";
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    } else {
      data['documents'] = [];
    }
    data['createdOn'] = createdOn;
    data['modifiedOn'] = modifiedOn;
    data['clientId'] = clientId;
    return data;
  }
}
