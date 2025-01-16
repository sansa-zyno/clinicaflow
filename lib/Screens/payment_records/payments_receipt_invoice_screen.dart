import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/business_logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/data_layer/models/invoice/invoice.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';
import 'package:healtether_clinic_app/utils/receipt_pdf.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';
import 'package:healtether_clinic_app/widgets/text_list_tile.dart';
import 'package:intl/intl.dart';

import '../../widgets/green_line.dart';

class PaymentsReceiptInvoice extends StatefulWidget {
  const PaymentsReceiptInvoice({super.key});

  @override
  State<PaymentsReceiptInvoice> createState() => _PaymentsReceiptInvoiceState();
}

class _PaymentsReceiptInvoiceState extends State<PaymentsReceiptInvoice> {
  bool isloading = true;

  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*PaymentsBloc paymentsBloc = BlocProvider.of<PaymentsBloc>(context, listen: false);
    final currentstate = paymentsBloc.state;
    if (currentstate is PaymentManageState) {
      List<PaymentModel> items = currentstate.items;

      bloc.add(InitialLoadEvent(items: items));
    }*/

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.paymentsReceipt),
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            topRow(state.invoiceDetails!.invoiceNumber!, state.invoiceDetails!.appointment!.appointmentDate!),
            const SizedBox(
              height: 16,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Patient : ',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '${state.invoiceDetails!.patient!.firstName} ${state.invoiceDetails!.patient!.lastName}',
                    style: const TextStyle(color: Color.fromARGB(255, 42, 56, 185), fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: Colors.grey[400],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  color: const Color(0xFFF8F7FC),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text("Treatments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Qty", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      /*Expanded(
                        flex: 2,
                        child: Text("Tax Amt.", textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),*/
                      Expanded(
                        flex: 2,
                        child: Text("Amt.", textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.invoiceDetails!.treatments!.length,
                    itemBuilder: (context, index) {
                      Treatment item = state.invoiceDetails!.treatments![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(item.treatment ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(item.quantity.toString(),
                                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                            ),
                            /*Expanded(
                              flex: 2,
                              child: Text("50.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                            ),*/
                            Expanded(
                              flex: 2,
                              child: Text(item.amount.toString(),
                                  textAlign: TextAlign.right, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                custom("Total Amt.", "-", state.invoiceDetails!.totalAmount.toString(), "INR",
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16), const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(height: 17),
                custom("Total Tax", "-", state.invoiceDetails!.totalTax.toString(), "INR", const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(height: 17),
                custom("Total Cost", "-", state.invoiceDetails!.totalCost.toString(), "INR",
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16), const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(height: 17),
                custom("Discount @${state.invoiceDetails!.discountRate}%", "-", state.invoiceDetails!.discount.toString(), "INR",
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16), const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 7),
            Divider(height: 1, color: Colors.grey[300]),
            Column(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: custom(
                      "Grand Total",
                      "-",
                      state.invoiceDetails!.totalCost.toString(),
                      "INR",
                      const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff4646B5)),
                      const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xff4646B5)))),
            ]),

            /*BlocBuilder<ReceiptBloc, ReceiptState>(
                bloc: bloc,
                buildWhen: (previous, current) => current is PaymentDoneState,
                builder: (context, state) {
                  if (state is PaymentSuccessfullState) {
                    return customRow("Balance Amt.", "-", "356", "INR", const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                  }
                  return Container();
                },
              ),*/
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                SizedBox(
                  width: 250,
                  child: GestureDetector(
                    onTap: () {
                      sendPaymentLink(context, state.invoiceDetails!);
                    },
                    child: const CustomButton(
                      data: "Send payment link ",
                      Textsize: 14,
                      Textcolor: Colors.white,
                      height: 50,
                      color: Color(0xff32856E),
                      icon: ImageIcon(
                        AssetImage('assets/homeimages/whatsapp12.png'),
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                SizedBox(
                  width: 250,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 235, 239),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if ((state.invoiceDetails?.paidAmount ?? -1) == (state.invoiceDetails?.totalAmount ?? -2)) {
                                  showSnackbar('Already paid', context);
                                } else {
                                  payInCash(context, state.invoiceDetails!);
                                }
                              },
                              child: const Text(
                                "Pay in cash",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.grey[350],
                        ),
                        SizedBox(
                            width: 40,
                            child: InkWell(
                                onTap: () async {
                                  String? res = await paymentMethods(context);
                                  if (res != null) {
                                    _paymentController.text = res;
                                  }
                                },
                                child: const Icon(Icons.keyboard_arrow_down)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      }),
    );
  }

  Widget custom(
    String leadingText,
    String middleText,
    String trailingText,
    String unit,
    TextStyle leadingTextStyle,
    TextStyle trailingTextStyle,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(leadingText, style: leadingTextStyle),
        ),
        Expanded(
          flex: 1,
          child: Text(middleText, textAlign: TextAlign.center, style: leadingTextStyle),
        ),
        Expanded(
          flex: 2,
          child: Text(trailingText, textAlign: TextAlign.right, style: trailingTextStyle),
        ),
        Expanded(
          flex: 1,
          child: Text(unit, textAlign: TextAlign.right, style: trailingTextStyle),
        ),
      ],
    );
  }

  Widget topRow(String invoiceNo, DateTime appointmentDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Invoice: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: invoiceNo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          DateFormat('d MMMM, yyyy').format(appointmentDate).toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget rowTextfield(String name, TextEditingController controller, String hint, bool readOnly) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: CustomTextField(
            readOnly: readOnly,
            controller: controller,
            keyBoardType: TextInputType.number,
            hintText: hint,
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Field cannot be empty';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Future sendPaymentLink(BuildContext context, Invoice invoiceDetails) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (context) => Container(
        height: 370,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'The payment link has been sent successfully.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Note: When the payment is received, it will be updated into the system.',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
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
                  ReceiptPdf().generate(context, invoiceDetails);
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
                context.pop();
                context.pop();
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

  Future payInCash(BuildContext context, Invoice invoiceDetails) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.state == PaymentStates.paymentAdded) {
            context.pop();
            Invoice newInvoice = state.invoice!;
            newInvoice.patient = invoiceDetails.patient;
            newInvoice.appointment = invoiceDetails.appointment;
            context.goNamed(AppRoutes.payInCashSuccess.name, extra: newInvoice);
          } else if (state.state == PaymentStates.addingPaymentFailed) {
            context.pop();
            if (state.error != null) {
              showSnackbar(state.error!, context);
            }
          }
        },
        child: BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
          return Container(
            height: 320,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MAKE PAYMENTS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const GreenLine(),
                const SizedBox(height: 8),
                const Text(
                  "Pay by cash",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter the Amount to be received by cash.",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                ),
                const SizedBox(height: 8),
                rowTextfield("Amount Received", _cashController, "In rupees(INR)", false),
                const SizedBox(height: 8),
                rowTextfield("Payment Mode", _paymentController, "Payment method", true),
                const SizedBox(height: 16),
                state.state == PaymentStates.addingPayment
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    if (_paymentController.text.isNotEmpty) {
                                      context.read<PaymentCubit>().setCashPayment(
                                            invoiceId: invoiceDetails.id!,
                                            amount: int.parse(_cashController.text),
                                            paymentMode: _paymentController.text.toLowerCase(),
                                          );
                                    } else {
                                      context.pop();
                                      showSnackbar('You need to select a payment method', context);
                                    }
                                  },
                                  child: const CustomButton(
                                    data: "Pay",
                                    height: 50,
                                    Textsize: 13,
                                    color: Color(0xff32856E),
                                    Textcolor: Colors.white,
                                  ))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: context.pop,
                              child: CustomButton(
                                data: "Go Back",
                                height: 50,
                                Textsize: 13,
                                Textcolor: Color(0xff32856E),
                                border: Border.all(color: Color(0xff32856E)),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<String?> paymentMethods(BuildContext context) async {
    bool creditCard = false;
    bool debitCard = false;
    bool paytm = false;
    bool gpay = false;
    bool upi = false;
    bool other = false;
    String? res = await showModalBottomSheet<String>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextListTile(
                  backgroundColor: creditCard ? null : Colors.white,
                  height: 58,
                  text: 'Credit Card',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = true;
                      debitCard = false;
                      paytm = false;
                      gpay = false;
                      upi = false;
                      other = false;
                    });
                    context.pop('Credit Card');
                  },
                ).pOnly(bottom: 10),
                TextListTile(
                  backgroundColor: debitCard ? null : Colors.white,
                  height: 58,
                  text: 'Debit Card',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = false;
                      debitCard = true;
                      paytm = false;
                      gpay = false;
                      upi = false;
                      other = false;
                    });
                    context.pop('Debit Card');
                  },
                ).pOnly(bottom: 10),
                TextListTile(
                  backgroundColor: paytm ? null : Colors.white,
                  height: 58,
                  text: 'Paytm',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = false;
                      debitCard = false;
                      paytm = true;
                      gpay = false;
                      upi = false;
                      other = false;
                    });
                    context.pop('Paytm');
                  },
                ).pOnly(bottom: 10),
                TextListTile(
                  backgroundColor: gpay ? null : Colors.white,
                  height: 58,
                  text: 'Gpay',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = false;
                      debitCard = false;
                      paytm = false;
                      gpay = true;
                      upi = false;
                      other = false;
                    });
                    context.pop('Gpay');
                  },
                ).pOnly(bottom: 10),
                TextListTile(
                  backgroundColor: upi ? null : Colors.white,
                  height: 58,
                  text: 'UPI',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = false;
                      debitCard = false;
                      paytm = false;
                      gpay = false;
                      upi = true;
                      other = false;
                    });
                    context.pop('UPI');
                  },
                ).pOnly(bottom: 10),
                TextListTile(
                  backgroundColor: other ? null : Colors.white,
                  height: 58,
                  text: 'Other',
                  padding: const EdgeInsets.only(left: 16),
                  onTap: () {
                    setState(() {
                      creditCard = false;
                      debitCard = false;
                      paytm = false;
                      gpay = false;
                      upi = false;
                      other = true;
                    });
                    context.pop('Other');
                  },
                ).pOnly(bottom: 10),
              ],
            ),
          ),
        );
      }),
    );
    return res;
  }
}
