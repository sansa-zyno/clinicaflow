// class Payment {
//   String id;
//   double amount;
//   String currency;
//   DateTime date;
//   String status;
//
//   Payment({
//     required this.id,
//     required this.amount,
//     required this.currency,
//     required this.date,
//     required this.status,
//   });
//
//   factory Payment.fromJson(Map<String, dynamic> json) {
//     return Payment(
//       id: json['id'],
//       amount: json['amount'].toDouble(),
//       currency: json['currency'],
//       date: DateTime.parse(json['date']),
//       status: json['status'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'amount': amount,
//       'currency': currency,
//       'date': date.toIso8601String(),
//       'status': status,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'Payment{id: $id, amount: $amount, currency: $currency, date: $date, status: $status}';
//   }
// }



class PaymentRecord {
  List<PaymentModel>? data;
  int? totalCount;

  PaymentRecord({this.data, this.totalCount});

  PaymentRecord.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentModel>[];
      json['data'].forEach((v) {
        data!.add(PaymentModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class PaymentModel {
  String? sId;
  String? mobile;
  String? name;
  String? appointmentDate;
  String? timeSlot;
  bool? virtualConsultation;
  bool? paymentStatus;
  String? doctorName;
  String? patientId;
  List<Invoicedetail>? invoicedetail;
  String? id;

  PaymentModel(
      {this.sId,
        this.mobile,
        this.name,
        this.appointmentDate,
        this.timeSlot,
        this.virtualConsultation,
        this.paymentStatus,
        this.doctorName,
        this.patientId,
        this.invoicedetail,
        this.id});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobile = json['mobile'];
    name = json['name'];
    appointmentDate = json['appointmentDate'];
    timeSlot = json['timeSlot'];
    virtualConsultation = json['virtualConsultation'];
    paymentStatus = json['paymentStatus'];
    doctorName = json['doctorName'];
    patientId = json['patientId'];
    if (json['invoicedetail'] != null) {
      invoicedetail = <Invoicedetail>[];
      json['invoicedetail'].forEach((v) {
        invoicedetail!.add(Invoicedetail.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobile'] = mobile;
    data['name'] = name;
    data['appointmentDate'] = appointmentDate;
    data['timeSlot'] = timeSlot;
    data['virtualConsultation'] = virtualConsultation;
    data['paymentStatus'] = paymentStatus;
    data['doctorName'] = doctorName;
    data['patientId'] = patientId;
    if (invoicedetail != null) {
      data['invoicedetail'] =
          invoicedetail!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Invoicedetail {
  String? sId;
  String? appointmentId;
  PaidAmount? paidAmount;
  PaidAmount? totalAmount;
  PaidAmount? totalCost;

  Invoicedetail.InvoiceDetail(
      {this.sId,
        this.appointmentId,
        this.paidAmount,
        this.totalAmount,
        this.totalCost});

  Invoicedetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    paidAmount = json['paidAmount'] != null
        ? PaidAmount.fromJson(json['paidAmount'])
        : null;
    totalAmount = json['totalAmount'] != null
        ? PaidAmount.fromJson(json['totalAmount'])
        : null;
    totalCost = json['totalCost'] != null
        ? PaidAmount.fromJson(json['totalCost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['appointmentId'] = appointmentId;
    if (paidAmount != null) {
      data['paidAmount'] = paidAmount!.toJson();
    }
    if (totalAmount != null) {
      data['totalAmount'] = totalAmount!.toJson();
    }
    if (totalCost != null) {
      data['totalCost'] = totalCost!.toJson();
    }
    return data;
  }
}

class PaidAmount {
  String? numberDecimal;

  PaidAmount({this.numberDecimal});

  PaidAmount.fromJson(Map<String, dynamic> json) {
    numberDecimal = json['$numberDecimal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$numberDecimal'] = numberDecimal;
    return data;
  }
}