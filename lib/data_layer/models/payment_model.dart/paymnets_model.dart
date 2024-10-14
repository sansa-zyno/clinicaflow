import 'package:flutter/material.dart';

class PaymentModel{
  final GlobalKey<FormState> formKey;
 final TextEditingController treatmentController;
 final TextEditingController amountController;
 final TextEditingController quantityController;
 final TextEditingController rateController;
  bool Isselected;

  PaymentModel({required this.treatmentController, required this.amountController, required this.quantityController, required this.rateController,this.Isselected=false,required this.formKey});


}