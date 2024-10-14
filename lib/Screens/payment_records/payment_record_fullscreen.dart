// import 'package:flutter/material.dart';
// import 'package:healtether_clinic_app/Screens/payment_records/qr_scanner_screen.dart';
// import 'package:healtether_clinic_app/constant/constant.dart';
// import '../../utils/customButton.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class PaymentRecordFullScreen extends StatefulWidget {
//   @override
//   _PaymentRecordFullScreenState createState() => _PaymentRecordFullScreenState();
// }
//
// class _PaymentRecordFullScreenState extends State<PaymentRecordFullScreen> {
//   List<Payment> payments = [];
//   bool isLoading = true;
//   String errorMessage = '';yyyy
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPayments('your_token_here'); // Replace 'your_token_here' with the actual token
//   }
//
//   Future<void> fetchPayments(String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://api-uhi.azurewebsites.net/api/payment/getpayments?clientId=65be5ecf4d5cb412fc374d60&page=1&size=5'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final List<dynamic> rawData = jsonData['data'];
//         setState(() {
//           payments = rawData.map<Payment>((json) => Payment.fromJson(json)).toList();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load payments';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'An error occurred';
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Payment Records',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//             ? Center(child: Text(errorMessage))
//             : ListView.builder(
//           itemCount: payments.length,
//           itemBuilder: (context, index) {
//             final payment = payments[index];
//             return PaymentDetails(
//               name: payment.name,
//               number: payment.mobile,
//               status: payment.paymentStatus ? 'completed' : 'pending',
//               totalAmount: payment.totalAmount,
//               paidAmount: payment.paidAmount,
//               doctorName: payment.doctorName,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class PaymentDetails extends StatelessWidget {
//   final String name;
//   final String number;
//   final String status;
//   final double totalAmount;
//   final double paidAmount;
//   final String doctorName;
//
//   const PaymentDetails({
//     Key? key,
//     required this.name,
//     required this.number,
//     required this.status,
//     required this.totalAmount,
//     required this.paidAmount,
//     required this.doctorName,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         detailsColumn(),
//         const SizedBox(height: 20),
//         CustomButton(
//           data: status,
//           color: status == "pending"
//               ? const Color(0xffFCD4CF)
//               : const Color(0xffE6EDE2),
//           border: Border.all(
//               color: status == "pending"
//                   ? AppColors.redColor
//                   : AppColors.grennColor,
//               width: 1),
//           height: 42,
//           Textcolor: status == "pending"
//               ? AppColors.redColor
//               : AppColors.grennColor,
//         ),
//         const SizedBox(height: 16),
//         Divider(height: 1, color: Colors.grey[400]),
//         const SizedBox(height: 10),
//         customRow(
//           "Total Fee",
//           ":",
//           totalAmount.toStringAsFixed(2),
//           "INR",
//           firstStyle: const TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.2,
//             color: Color(0xFF202741),
//           ),
//           secondStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF110C2C),
//           ),
//           thirdStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF110C2C),
//           ),
//           fourthStyle: TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.35,
//             color: Color(0xFF110C2C),
//           ),
//         ),
//         const SizedBox(height: 10),
//         customRow(
//           "Amt.\nReceived",
//           ":",
//           paidAmount.toStringAsFixed(2),
//           "INR",
//           firstStyle: const TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.2,
//             color: Color(0xFF202741),
//           ),
//           secondStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF110C2C),
//           ),
//           thirdStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF110C2C),
//           ),
//           fourthStyle: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.2,
//             color: Color(0xFF202741),
//           ),
//         ),
//         const SizedBox(height: 10),
//         customRow(
//           "Balance Amt",
//           ":",
//           (totalAmount - paidAmount).toStringAsFixed(2),
//           "INR",
//           firstStyle: const TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.2,
//             color: Color(0xFF202741),
//           ),
//           secondStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF110C2C),
//           ),
//           thirdStyle: const TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             height: 1.25,
//             color: Color(0xFF14646B5),
//           ),
//           fourthStyle: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w600,
//             fontSize: 16.0,
//             height: 1.2,
//             color: Color(0xFF202741),
//           ),
//         ),
//         Divider(height: 1, color: Colors.grey[400]),
//         const SizedBox(height: 16),
//         GestureDetector(
//           onTap: () {},
//           child: CustomButton(
//             data: AppText.sendPaymentLink,
//             Textcolor: AppColors.whiteColor,
//             height: 55,
//             color: const Color(0xff32856E),
//           ),
//         ),
//         const SizedBox(height: 12),
//         GestureDetector(
//           onTap: () {},
//           child: CustomButton(
//             data: AppText.viewReceipt,
//             height: 55,
//             color: Color.fromARGB(255, 236, 235, 239),
//           ),
//         ),
//         const SizedBox(height: 12),
//         GestureDetector(
//           onTap: () {},
//           child: CustomButton(
//             data: AppText.payByCash,
//             height: 55,
//             color: Color.fromARGB(255, 236, 235, 239),
//           ),
//         ),
//         const SizedBox(height: 12),
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => QRScannerScreen()),
//             // );
//           },
//           child: CustomButton(
//             data: AppText.scanQr,
//             height: 55,
//             color: Color.fromARGB(255, 236, 235, 239),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
//
//   Widget detailsColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           name,
//           style: const TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff4646B5)),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           number,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 8),
//         Text("Last visited : 12/7/23"),
//       ],
//     );
//   }
//
//   Widget customRow(String first, String second, String third, String fourth,
//       {TextStyle? firstStyle,
//         TextStyle? secondStyle,
//         TextStyle? thirdStyle,
//         TextStyle? fourthStyle}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             alignment: Alignment.centerLeft,
//             child: Text(first, style: firstStyle),
//           ),
//         ),
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             alignment: Alignment.centerRight,
//             child: Text(second, style: secondStyle),
//           ),
//         ),
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             alignment: Alignment.centerRight,
//             child: Text(third, style: thirdStyle),
//           ),
//         ),
//         Expanded(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             alignment: Alignment.centerRight,
//             child: Text(fourth, style: fourthStyle),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class Payment {
//   final String id;
//   final String mobile;
//   final String name;
//   final bool paymentStatus;
//   final double totalAmount;
//   final double paidAmount;
//   final String doctorName;
//
//   Payment({
//     required this.id,
//     required this.mobile,
//     required this.name,
//     required this.paymentStatus,
//     required this.totalAmount,
//     required this.paidAmount,
//     required this.doctorName,
//   });
//
//   factory Payment.fromJson(Map<String, dynamic> json) {
//     final invoiceDetails = json['invoicedetail'][0];
//     return Payment(
//       id: json['_id'],
//       mobile: json['mobile'],
//       name: json['name'],
//       paymentStatus: json['paymentStatus'],
//       totalAmount: double.parse(invoiceDetails['totalAmount']['\$numberDecimal']),
//       paidAmount: double.parse(invoiceDetails['paidAmount']['\$numberDecimal']),
//       doctorName: json['doctorName'],
//     );
//   }
// }
//
// class PaymentService {
//   static Future<List<Payment>> fetchPayments(String token) async {
//     final response = await http.get(
//       Uri.parse(
//           'https://api-uhi.azurewebsites.net/api/payment/getpayments?clientId=65be5ecf4d5cb412fc374d60&page=1&size=5'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final List<dynamic> rawData = jsonData['data'];
//
//       return rawData.map<Payment>((json) => Payment.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load payments');
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_models/payment_response_model.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';

class PaymentRecordFullScreen extends StatelessWidget {
  final GetPayment payment;
  final String name;
  final String number;
  final String status;
  final String date;
  const PaymentRecordFullScreen(
      {super.key,
      required this.name,
      required this.number,
      required this.status,
      required this.payment,
      required this.date});

  @override
  Widget build(BuildContext context) {
    // late PaymentProvider paymentProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Records',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailsColumn(),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              data: status,
              color: status == "Pending"
                  ? const Color(0xffFCD4CF)
                  : const Color(0xffE6EDE2),
              border: Border.all(
                  color: status == "Pending"
                      ? AppColors.redColor
                      : AppColors.grennColor,
                  width: 1),
              height: 42,
              Textcolor: status == "Pending"
                  ? AppColors.redColor
                  : AppColors.grennColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
            const SizedBox(
              height: 10,
            ),
            customRow(
                "Total Fee",
                ":",
                payment.invoiceDetail[0].paidAmount.toString(),
// payment.invoicedetail![0].totalAmount.toString(),

                // "556.00",
                "INR",
                firstStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 1.2,
                  color: Color(0xFF202741),
                ),
                secondStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  height: 1.25,
                  color: Color(0xFF110C2C),
                ),
                thirdStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  height: 1.25,
                  color: Color(0xFF110C2C),
                ),
                fourthStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 1.35,
                  color: Color(0xFF110C2C),
                )),
            const SizedBox(height: 10),
            customRow(
              "Amt.\nReceived",
              ":",
              // number: payment.invoiceDetail[index].totalCost.toString() ?? '',
              payment.invoiceDetail[0].totalAmount.toString(),
              // "200.00",
              "INR",
              firstStyle: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                height: 1.2,
                color: Color(0xFF202741),
              ),

              secondStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1.25,
                color: Color(0xFF110C2C),
              ),
              thirdStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1.25,
                color: Color(0xFF110C2C),
              ),
              fourthStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                height: 1.2,
                color: Color(0xFF202741),
              ),
            ),
            const SizedBox(height: 10),
            customRow(
              "Balance Amt",
              ":",
              payment.invoiceDetail[0].totalCost.toString(),
              // payment.invoicedetail![0].totalCost!.toString(),
              //  "356.00",
              "INR",
              firstStyle: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                height: 1.2,
                color: Color(0xFF202741),
              ),

              secondStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1.25,
                color: Color(0xFF110C2C),
              ),
              thirdStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                height: 1.25,
                color: Color(0xFF14646B5),
              ),
              fourthStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                height: 1.2,
                color: Color(0xFF202741),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: CustomButton(
                  data: AppText.sendPaymentLink,
                  Textcolor: AppColors.whiteColor,
                  height: 55,
                  color: const Color(0xff32856E)),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {},
              child: CustomButton(
                data: AppText.viewReceipt,
                height: 55,
                color: Color.fromARGB(255, 236, 235, 239),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {},
              child: CustomButton(
                data: AppText.payByCash,
                height: 55,
                color: Color.fromARGB(255, 236, 235, 239),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => QRScannerScreen()),
                // );
              },
              child: CustomButton(
                data: AppText.scanQr,
                height: 55,
                color: Color.fromARGB(255, 236, 235, 239),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Color(0xff4646B5)),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          number,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text("Last visited : $date"),
      ],
    );
  }

  Widget customRow(String first, String second, String third, String fourth,
      {TextStyle? firstStyle,
      TextStyle? secondStyle,
      TextStyle? thirdStyle,
      TextStyle? fourthStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(first, style: firstStyle),
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(second, style: secondStyle),
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(third, style: thirdStyle),
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(fourth, style: fourthStyle),
          ),
        ),
      ],
    );
  }
}
