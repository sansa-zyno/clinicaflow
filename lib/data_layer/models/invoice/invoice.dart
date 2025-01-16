import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  int? totalAmount;
  int? totalTax;
  int? totalCost;
  int? discountRate;
  int? discount;
  int? paidAmount;
  List<Treatment>? treatments;
  String? invoiceNumber;
  Created? created;
  String? id;
  Patient? patient;
  Appointment? appointment;

  Invoice({
    this.totalAmount,
    this.totalTax,
    this.totalCost,
    this.discountRate,
    this.discount,
    this.paidAmount,
    this.treatments,
    this.invoiceNumber,
    this.created,
    this.id,
    this.patient,
    this.appointment,
  });

  Invoice copyWith({
    int? totalAmount,
    int? totalTax,
    int? totalCost,
    int? discountRate,
    int? discount,
    int? paidAmount,
    List<Treatment>? treatments,
    String? invoiceNumber,
    Created? created,
    String? id,
    Patient? patient,
    Appointment? appointment,
  }) =>
      Invoice(
        totalAmount: totalAmount ?? this.totalAmount,
        totalTax: totalTax ?? this.totalTax,
        totalCost: totalCost ?? this.totalCost,
        discountRate: discountRate ?? this.discountRate,
        discount: discount ?? this.discount,
        paidAmount: paidAmount ?? this.paidAmount,
        treatments: treatments ?? this.treatments,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        created: created ?? this.created,
        id: id ?? this.id,
        patient: patient ?? this.patient,
        appointment: appointment ?? this.appointment,
      );

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        totalAmount: json["totalAmount"],
        totalTax: json["totalTax"],
        totalCost: json["totalCost"],
        discountRate: json["discountRate"],
        discount: json["discount"],
        paidAmount: json["paidAmount"],
        treatments: json["treatments"] == null ? [] : List<Treatment>.from(json["treatments"]!.map((x) => Treatment.fromJson(x))),
        invoiceNumber: json["invoiceNumber"],
        created: json["created"] == null ? null : Created.fromJson(json["created"]),
        id: json["_id"],
        patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        appointment: json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "totalTax": totalTax,
        "totalCost": totalCost,
        "discountRate": discountRate,
        "discount": discount,
        "paidAmount": paidAmount,
        "treatments": treatments == null ? [] : List<dynamic>.from(treatments!.map((x) => x.toJson())),
        "invoiceNumber": invoiceNumber,
        "created": created?.toJson(),
        "_id": id,
        "patient": patient?.toJson(),
        "appointment": appointment?.toJson(),
      };
}

class Appointment {
  DateTime? appointmentDate;

  Appointment({
    this.appointmentDate,
  });

  Appointment copyWith({
    DateTime? appointmentDate,
  }) =>
      Appointment(
        appointmentDate: appointmentDate ?? this.appointmentDate,
      );

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentDate: json["appointmentDate"] == null ? null : DateTime.parse(json["appointmentDate"]),
      );

  Map<String, dynamic> toJson() => {
        "appointmentDate": appointmentDate?.toIso8601String(),
      };
}

class Created {
  By? by;
  DateTime? on;

  Created({
    this.by,
    this.on,
  });

  Created copyWith({
    By? by,
    DateTime? on,
  }) =>
      Created(
        by: by ?? this.by,
        on: on ?? this.on,
      );

  factory Created.fromJson(Map<String, dynamic> json) => Created(
        by: json["by"] == null ? null : By.fromJson(json["by"]),
        on: json["on"] == null ? null : DateTime.parse(json["on"]),
      );

  Map<String, dynamic> toJson() => {
        "by": by?.toJson(),
        "on": on?.toIso8601String(),
      };
}

class By {
  String? id;
  String? name;

  By({
    this.id,
    this.name,
  });

  By copyWith({
    String? id,
    String? name,
  }) =>
      By(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory By.fromJson(Map<String, dynamic> json) => By(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Patient {
  String? firstName;
  String? lastName;
  String? patientId;

  Patient({
    this.firstName,
    this.lastName,
    this.patientId,
  });

  Patient copyWith({
    String? firstName,
    String? lastName,
    String? patientId,
  }) =>
      Patient(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        patientId: patientId ?? this.patientId,
      );

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        firstName: json["firstName"],
        lastName: json["lastName"],
        patientId: json["patientId"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "patientId": patientId,
      };
}

class Treatment {
  String? treatment;
  int? quantity;
  num? amount;
  int? discRate;

  Treatment({
    this.treatment,
    this.quantity,
    this.amount,
    this.discRate,
  });

  Treatment copyWith({
    String? treatment,
    int? quantity,
    num? amount,
    int? discRate,
  }) =>
      Treatment(
        treatment: treatment ?? this.treatment,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        discRate: discRate ?? this.discRate,
      );

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        treatment: json["treatment"],
        quantity: json["quantity"],
        amount: json["amount"],
        discRate: json["discRate"],
      );

  Map<String, dynamic> toJson() => {
        "treatment": treatment,
        "quantity": quantity,
        "amount": amount,
        "discRate": discRate,
      };
}
