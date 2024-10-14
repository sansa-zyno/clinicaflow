class PatientByIdModel {
  PatientByIdModel({
    required this.address,
    required this.id,
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.height,
    required this.weight,
    required this.birthday,
    required this.gender,
    required this.mobile,
    required this.email,
    required this.documentType,
    required this.documentNumber,
    required this.documents,
    required this.patientByIdModelId,
  });

  final Address? address;
  final String id;
  final String patientId;
  final String firstName;
  final String lastName;
  final int age;
  final int height;
  final int weight;
  final DateTime? birthday;
  final String gender;
  final String mobile;
  final String email;
  final String documentType;
  final String documentNumber;
  final List<dynamic> documents;
  final String patientByIdModelId;

  PatientByIdModel copyWith({
    Address? address,
    String? id,
    String? patientId,
    String? firstName,
    String? lastName,
    int? age,
    int? height,
    int? weight,
    DateTime? birthday,
    String? gender,
    String? mobile,
    String? email,
    String? documentType,
    String? documentNumber,
    List<dynamic>? documents,
    String? patientByIdModelId,
  }) {
    return PatientByIdModel(
      address: address ?? this.address,
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      documents: documents ?? this.documents,
      patientByIdModelId: patientByIdModelId ?? this.patientByIdModelId,
    );
  }

  factory PatientByIdModel.fromJson(Map<String, dynamic> json) {
    return PatientByIdModel(
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      id: json["_id"] ?? "",
      patientId: json["patientId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      age: json["age"] ?? 0,
      height: json["height"] ?? 0,
      weight: json["weight"] ?? 0,
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      gender: json["gender"] ?? "",
      mobile: json["mobile"] ?? "",
      email: json["email"] ?? "",
      documentType: json["documentType"] ?? "",
      documentNumber: json["documentNumber"] ?? "",
      documents: json["documents"] == null
          ? []
          : List<dynamic>.from(json["documents"]!.map((x) => x)),
      patientByIdModelId: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "_id": id,
        "patientId": patientId,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "height": height,
        "weight": weight,
        "birthday": birthday?.toIso8601String(),
        "gender": gender,
        "mobile": mobile,
        "email": email,
        "documentType": documentType,
        "documentNumber": documentNumber,
        "documents": documents.map((x) => x).toList(),
        "id": patientByIdModelId,
      };

  @override
  String toString() {
    return "$address, $id, $patientId, $firstName, $lastName, $age, $height, $weight, $birthday, $gender, $mobile, $email, $documentType, $documentNumber, $documents, $patientByIdModelId, ";
  }
}

class Address {
  Address({
    required this.house,
    required this.street,
    required this.landmarks,
    required this.city,
    required this.pincode,
  });

  final String house;
  final String street;
  final String landmarks;
  final String city;
  final String pincode;

  Address copyWith({
    String? house,
    String? street,
    String? landmarks,
    String? city,
    String? pincode,
  }) {
    return Address(
      house: house ?? this.house,
      street: street ?? this.street,
      landmarks: landmarks ?? this.landmarks,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      house: json["house"] ?? "",
      street: json["street"] ?? "",
      landmarks: json["landmarks"] ?? "",
      city: json["city"] ?? "",
      pincode: json["pincode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "house": house,
        "street": street,
        "landmarks": landmarks,
        "city": city,
        "pincode": pincode,
      };

  @override
  String toString() {
    return "$house, $street, $landmarks, $city, $pincode, ";
  }
}
