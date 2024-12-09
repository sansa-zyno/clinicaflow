class Payment {
  String treatmentName;
  double? quantity;
  double? amount;
  double? discount;

  Payment({required this.treatmentName, required this.quantity, required this.amount, required this.discount});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        treatmentName: json["treatmentName"],
        quantity: json["quantity"],
        amount: json["Amount"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "treatmentName": treatmentName,
        "quantity": quantity,
        "Amount": amount,
        "discount": discount,
      };
}
