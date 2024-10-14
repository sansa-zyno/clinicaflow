class PatientModel {
    String firstName;
    String lastName;
    int age;
    DateTime birthday;
    String gender;
    String mobile;
    String patientId;
    Address? address;
    double? height;
    double? weight;
    String documentType;
    String documentNumber;
    List<Document>? documents;
    dynamic appointment;

    PatientModel({
        required this.firstName,
        required this.lastName,
        required this.age,
        required this.birthday,
        required this.gender,
        required this.mobile,
        required this.patientId,
        required this.address,
        required this.height,
        required this.weight,
        required this.documentType,
        required this.documentNumber,
        required this.documents,
        required this.appointment,
    });

    factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        age: json["age"],
        birthday: DateTime.parse(json["birthday"]),
        gender: json["gender"],
        mobile: json["mobile"],
        patientId: json["patientId"],
        address: Address.fromJson(json["address"]),
        height: json["height"]?.toDouble(),
        weight: json["weight"]?.toDouble(),
        documentType: json["documentType"],
        documentNumber: json["documentNumber"],
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
        appointment: json["appointment"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "birthday": birthday.toIso8601String(),
        "gender": gender,
        "mobile": mobile,
        "patientId": patientId,
        "address": address!.toJson(),
        "height": height,
        "weight": weight,
        "documentType": documentType,
        "documentNumber": documentNumber,
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
        "appointment": appointment,
    };
}

class Address {
    String house;
    String street;
    String landmarks;
    String city;
    String pincode;

    Address({
        required this.house,
        required this.street,
        required this.landmarks,
        required this.city,
        required this.pincode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        house: json["house"],
        street: json["street"],
        landmarks: json["landmarks"],
        city: json["city"],
        pincode: json["pincode"],
    );

    Map<String, dynamic> toJson() => {
        "house": house,
        "street": street,
        "landmarks": landmarks,
        "city": city,
        "pincode": pincode,
    };
}

class Document {
    String fileName;
    String blobName;
    String id;

    Document({
        required this.fileName,
        required this.blobName,
        required this.id,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        fileName: json["fileName"],
        blobName: json["blobName"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "blobName": blobName,
        "_id": id,
    };
}