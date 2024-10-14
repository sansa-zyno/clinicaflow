import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => DocumentDetailsState();
}

class DocumentDetailsState extends State<PaymentDetails> {
  String? documentText = "Aadhar";
  final TextEditingController _number1controller =
      TextEditingController(text: "janedoes@ybl");

  final TextEditingController _number2controller =
      TextEditingController(text: "+91 9865 632142");

  final TextEditingController _emailcontroller =
      TextEditingController(text: "Jana Doe");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Details ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "UPI ID ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              controller: _number1controller,
              hintText: "janedoes@ybl",
            ),
            const SizedBox(
              height: 7,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "+  Add another UPI ID",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff009394),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
            const Text(
              "Bank Details ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "Indian Bank"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "5213 5123 6554 5894"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "IDBI000H013"),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(hintText: "Jane Doe"),
            const SizedBox(
              height: 7,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "+  Add another bank",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff009394),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
