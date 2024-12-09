class Appointments {
  String? appointmentDate;
  String? timeSlot;
  String? reason;
  bool? paymentStatus;
  String? doctorName;
  String? patientId;
  String? id;

  Appointments({
    this.appointmentDate,
    this.timeSlot,
    this.reason,
    this.paymentStatus,
    this.doctorName,
    this.patientId,
    this.id,
  });

  Appointments.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointmentDate'];
    timeSlot = json['timeSlot'];
    reason = json['reason'];
    paymentStatus = json['paymentStatus'];
    doctorName = json['doctorName'];
    patientId = json['patientId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentDate'] = appointmentDate;
    data['timeSlot'] = timeSlot;
    data['reason'] = reason;
    data['paymentStatus'] = paymentStatus;
    data['doctorName'] = doctorName;
    data['patientId'] = patientId;
    data['id'] = id;
    return data;
  }
}
