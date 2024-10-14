class Payment{


   String treatmentName;

   double? quantity;
   double? Amount;

   double? discount;

  Payment({required this.treatmentName, required this.quantity, required this.Amount, required this.discount});
   

 factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        treatmentName: json["treatmentName"],
        quantity: json["quantity"],
        Amount: json["Amount"],
        discount: json["discount"],
    );

Map<String, dynamic> toJson() =>{
        "treatmentName": treatmentName,
        "quantity": quantity,
        "Amount": Amount,
        "discount": discount,
    };

}