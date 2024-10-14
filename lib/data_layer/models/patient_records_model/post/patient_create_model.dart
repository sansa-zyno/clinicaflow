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

  PatientCreate.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    patientId = json['patientId'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    birthday = json['birthday'];
    gender = json['gender'];
    mobile = json['mobile'];
    email = json['email'];
    if (json['address'] != null) {
      address = AddressPatient.fromJson(json['address']);
    } else {
      address = null;
    }
    documentType = json['documentType'];
    documentNumber = json['documentNumber'];
    if (json['documents'] != null) {
      documents = <DocumentsPatient>[];
      json['documents'].forEach((v) {
        documents!.add(DocumentsPatient.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['patientId'] = patientId;
    data['age'] = age;
    data['height'] = height;
    data['weight'] = weight;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['documentType'] = documentType;
    data['documentNumber'] = documentNumber;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = createdOn;
    data['modifiedOn'] = modifiedOn;
    data['clientId'] = clientId;
    final Map<String, dynamic> finalData = <String, dynamic>{
      "patientData": data
    };
    return finalData;
  }
}
