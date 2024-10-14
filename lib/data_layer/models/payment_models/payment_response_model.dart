class GetPayment {
  String id;
  String mobile;
  String name;
  DateTime appointmentDate;
  String timeSlot;
  bool virtualConsultation;
  bool paymentStatus;
  String doctorName;
  String patientId;
  List<InvoiceDetail> invoiceDetail;

  GetPayment({
    required this.id,
    required this.mobile,
    required this.name,
    required this.appointmentDate,
    required this.timeSlot,
    required this.virtualConsultation,
    required this.paymentStatus,
    required this.doctorName,
    required this.patientId,
    required this.invoiceDetail,
  });

  factory GetPayment.fromJson(Map<String, dynamic> json) {
    return GetPayment(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      name: json['name'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate']),
      timeSlot: json['timeSlot'] ?? '',
      virtualConsultation: json['virtualConsultation'] ?? false,
      paymentStatus: json['paymentStatus'] ?? false,
      doctorName: json['doctorName'] ?? '',
      patientId: json['patientId'] ?? '',
      invoiceDetail: (json['invoicedetail'] as List)
          .map((i) => InvoiceDetail.fromJson(i))
          .toList(),
    );
  }
}

class InvoiceDetail {
  String id;
  String appointmentId;
  num paidAmount;
  num totalAmount;
  num totalCost;

  InvoiceDetail({
    required this.id,
    required this.appointmentId,
    required this.paidAmount,
    required this.totalAmount,
    required this.totalCost,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      id: json['_id'] ?? '',
      appointmentId: json['appointmentId'] ?? '',
      paidAmount: double.parse(json['paidAmount']['\$numberDecimal']),
      totalAmount: double.parse(json['totalAmount']['\$numberDecimal']),
      totalCost: double.parse(json['totalCost']['\$numberDecimal']),
    );
  }
}
