import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/invoice/invoice.dart';
import 'package:healtether_clinic_app/utils/receipt_pdf.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';

class PayInCashSuccessScreen extends StatefulWidget {
  final Invoice invoiceDetails;
  const PayInCashSuccessScreen({super.key, required this.invoiceDetails});

  @override
  State<PayInCashSuccessScreen> createState() => _PayInCashSuccessScreenState();
}

class _PayInCashSuccessScreenState extends State<PayInCashSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/png/saved_icon_big.png'),
            const SizedBox(
              height: 20,
            ),
            const Text('The payment was received successfully.'),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: CustomButton(
                color: AppColors.darkTeal,
                height: 58,
                data: 'Send on',
                Textcolor: Colors.white,
                Textsize: 14,
                icon: Image.asset(
                  'assets/png/whatsapp.png',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  ReceiptPdf().generate(context, widget.invoiceDetails);
                },
                child: const CustomButton(
                  color: AppColors.whiteSmoke,
                  height: 58,
                  Textsize: 14,
                  data: 'Print',
                )),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: const CustomButton(
                color: AppColors.whiteSmoke,
                height: 58,
                Textsize: 14,
                data: 'Exit',
              ),
            )
          ],
        ),
      ),
    );
  }
}
