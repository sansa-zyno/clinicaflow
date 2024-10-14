class StaffByIdModel {
  StaffByIdModel({
    required this.the1,
    required this.address,
    required this.created,
    required this.modified,
    required this.id,
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.isDoctor,
    required this.age,
    required this.birthday,
    required this.gender,
    required this.mobile,
    required this.countryCode,
    required this.email,
    required this.documentType,
    required this.documentNumber,
    required this.bankName,
    required this.accountName,
    required this.ifsc,
    required this.profilePic,
    required this.documents,
    required this.deleted,
    required this.clinic,
    required this.userId,
    required this.availableTimeSlot,
  });

  final Map<String, int> the1;
  final Address? address;
  final Created? created;
  final Created? modified;
  final String id;
  final String staffId;
  final String firstName;
  final String lastName;
  final String specialization;
  final bool isDoctor;
  final int age;
  final DateTime? birthday;
  final String gender;
  final String mobile;
  final String countryCode;
  final String email;
  final String documentType;
  final String documentNumber;
  final String bankName;
  final String accountName;
  final String ifsc;
  final String profilePic;
  final List<dynamic> documents;
  final bool deleted;
  final String clinic;
  final String userId;
  final List<AvailableTimeSlot> availableTimeSlot;

  StaffByIdModel copyWith({
    Map<String, int>? the1,
    Address? address,
    Created? created,
    Created? modified,
    String? id,
    String? staffId,
    String? firstName,
    String? lastName,
    String? specialization,
    bool? isDoctor,
    int? age,
    DateTime? birthday,
    String? gender,
    String? mobile,
    String? countryCode,
    String? email,
    String? documentType,
    String? documentNumber,
    String? bankName,
    String? accountName,
    String? ifsc,
    String? profilePic,
    List<dynamic>? documents,
    bool? deleted,
    String? clinic,
    String? userId,
    List<AvailableTimeSlot>? availableTimeSlot,
  }) {
    return StaffByIdModel(
      the1: the1 ?? this.the1,
      address: address ?? this.address,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      specialization: specialization ?? this.specialization,
      isDoctor: isDoctor ?? this.isDoctor,
      age: age ?? this.age,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      ifsc: ifsc ?? this.ifsc,
      profilePic: profilePic ?? this.profilePic,
      documents: documents ?? this.documents,
      deleted: deleted ?? this.deleted,
      clinic: clinic ?? this.clinic,
      userId: userId ?? this.userId,
      availableTimeSlot: availableTimeSlot ?? this.availableTimeSlot,
    );
  }

  factory StaffByIdModel.fromJson(Map<String, dynamic> json) {
    return StaffByIdModel(
      the1: Map.from(json["1"]).map((k, v) => MapEntry<String, int>(k, v)),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      created:
          json["created"] == null ? null : Created.fromJson(json["created"]),
      modified:
          json["modified"] == null ? null : Created.fromJson(json["modified"]),
      id: json["_id"] ?? "",
      staffId: json["staffId"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      specialization: json["specialization"] ?? "",
      isDoctor: json["isDoctor"] ?? false,
      age: json["age"] ?? 0,
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      gender: json["gender"] ?? "",
      mobile: json["mobile"] ?? "",
      countryCode: json["countryCode"] ?? "",
      email: json["email"] ?? "",
      documentType: json["documentType"] ?? "",
      documentNumber: json["documentNumber"] ?? "",
      bankName: json["bankName"] ?? "",
      accountName: json["accountName"] ?? "",
      ifsc: json["ifsc"] ?? "",
      profilePic: json["profilePic"] ?? "",
      documents: json["documents"] == null
          ? []
          : List<dynamic>.from(json["documents"]!.map((x) => x)),
      deleted: json["deleted"] ?? false,
      clinic: json["clinic"] ?? "",
      userId: json["userId"] ?? "",
      availableTimeSlot: json["availableTimeSlot"] == null
          ? []
          : List<AvailableTimeSlot>.from(json["availableTimeSlot"]!
              .map((x) => AvailableTimeSlot.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "1": Map.from(the1).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "address": address?.toJson(),
        "created": created?.toJson(),
        "modified": modified?.toJson(),
        "_id": id,
        "staffId": staffId,
        "firstName": firstName,
        "lastName": lastName,
        "specialization": specialization,
        "isDoctor": isDoctor,
        "age": age,
        "birthday": birthday?.toIso8601String(),
        "gender": gender,
        "mobile": mobile,
        "countryCode": countryCode,
        "email": email,
        "documentType": documentType,
        "documentNumber": documentNumber,
        "bankName": bankName,
        "accountName": accountName,
        "ifsc": ifsc,
        "profilePic": profilePic,
        "documents": documents.map((x) => x).toList(),
        "deleted": deleted,
        "clinic": clinic,
        "userId": userId,
        "availableTimeSlot": availableTimeSlot.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$the1, $address, $created, $modified, $id, $staffId, $firstName, $lastName, $specialization, $isDoctor, $age, $birthday, $gender, $mobile, $countryCode, $email, $documentType, $documentNumber, $bankName, $accountName, $ifsc, $profilePic, $documents, $deleted, $clinic, $userId, $availableTimeSlot, ";
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

class AvailableTimeSlot {
  AvailableTimeSlot({
    required this.weekDay,
    required this.timeSlot,
    required this.slotDuration,
    required this.id,
  });

  final List<String> weekDay;
  final List<TimeSlot> timeSlot;
  final int slotDuration;
  final String id;

  AvailableTimeSlot copyWith({
    List<String>? weekDay,
    List<TimeSlot>? timeSlot,
    int? slotDuration,
    String? id,
  }) {
    return AvailableTimeSlot(
      weekDay: weekDay ?? this.weekDay,
      timeSlot: timeSlot ?? this.timeSlot,
      slotDuration: slotDuration ?? this.slotDuration,
      id: id ?? this.id,
    );
  }

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) {
    return AvailableTimeSlot(
      weekDay: json["weekDay"] == null
          ? []
          : List<String>.from(json["weekDay"]!.map((x) => x)),
      timeSlot: json["timeSlot"] == null
          ? []
          : List<TimeSlot>.from(
              json["timeSlot"]!.map((x) => TimeSlot.fromJson(x))),
      slotDuration: json["slotDuration"] ?? 0,
      id: json["_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "weekDay": weekDay.map((x) => x).toList(),
        "timeSlot": timeSlot.map((x) => x?.toJson()).toList(),
        "slotDuration": slotDuration,
        "_id": id,
      };

  @override
  String toString() {
    return "$weekDay, $timeSlot, $slotDuration, $id, ";
  }
}

class TimeSlot {
  TimeSlot({
    required this.start,
    required this.end,
    required this.id,
  });

  final String start;
  final String end;
  final String id;

  TimeSlot copyWith({
    String? start,
    String? end,
    String? id,
  }) {
    return TimeSlot(
      start: start ?? this.start,
      end: end ?? this.end,
      id: id ?? this.id,
    );
  }

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      start: json["start"] ?? "",
      end: json["end"] ?? "",
      id: json["_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "_id": id,
      };

  @override
  String toString() {
    return "$start, $end, $id, ";
  }
}

class Created {
  Created({
    required this.by,
    required this.on,
  });

  final By? by;
  final DateTime? on;

  Created copyWith({
    By? by,
    DateTime? on,
  }) {
    return Created(
      by: by ?? this.by,
      on: on ?? this.on,
    );
  }

  factory Created.fromJson(Map<String, dynamic> json) {
    return Created(
      by: json["by"] == null ? null : By.fromJson(json["by"]),
      on: DateTime.tryParse(json["on"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "by": by?.toJson(),
        "on": on?.toIso8601String(),
      };

  @override
  String toString() {
    return "$by, $on, ";
  }
}

class By {
  By({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  By copyWith({
    String? id,
    String? name,
  }) {
    return By(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory By.fromJson(Map<String, dynamic> json) {
    return By(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return "$id, $name, ";
  }
}
