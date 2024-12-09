import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/business_logic/blocs/payment_bloc/payments_bloc.dart';
import 'package:healtether_clinic_app/business_logic/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_model.dart/paymnets_model.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:healtether_clinic_app/widgets/CustomTextField.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';
import 'package:intl/intl.dart';

class PaymentsReceipt extends StatefulWidget {
  const PaymentsReceipt({super.key});

  @override
  State<PaymentsReceipt> createState() => _PaymentsReceiptState();
}

class _PaymentsReceiptState extends State<PaymentsReceipt> {
  bool isloading = true;

  ReceiptBloc bloc = ReceiptBloc();
  final TextEditingController _cashController = TextEditingController();

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AMOUNT PAID BY CASH",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            //const GreenLine(),
            const SizedBox(
              height: 8,
            ),
            RowTextfield("Amount Received", _cashController, "in Rupeess    INR"),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          context.goNamed(AppRoutes.paymentReceiptScreen.name);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const PaymentsReceiptScreens();
                          // }));
                        },
                        child: const CustomButton(
                          data: "Next",
                          height: 50,
                          color: Color(0xff32856E),
                          Textcolor: Colors.white,
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: context.pop,
                    child: const CustomButton(data: "Back", height: 50, color: Color.fromARGB(255, 223, 221, 229)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PaymentsBloc paymentsBloc = BlocProvider.of<PaymentsBloc>(context, listen: false);
    final currentstate = paymentsBloc.state;
    if (currentstate is PaymentManageState) {
      List<PaymentModel> items = currentstate.items;

      bloc.add(InitialLoadEvent(items: items));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const Text(
              "Payments Reciept",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 25,
              ))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),

          topRow(),

          const SizedBox(
            height: 16,
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Patient : ',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'Ramesh Patel',
                  style: TextStyle(color: Color.fromARGB(255, 42, 56, 185), fontSize: 23, fontWeight: FontWeight.w500),
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
                color: const Color(0xFFF8F7FC),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Treatments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Qty", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Tax\n Amt.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Amt.", textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("Consultaion", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("1", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("50.00", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("500.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text("IV drip", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("1", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("18.00", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("50.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ],
          ),

          // customRow("Treatments", "Qty", "Tax Amt.", "Amt.",const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
          // customRow("Treatments", "Qty", "Tax Amt.", "Amt.",const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
          // const SizedBox(height: 16,),
          // BlocBuilder<ReceiptBloc, ReceiptState>(
          //  bloc: bloc,
          //  buildWhen: (previous, current) => current is !PaymentDoneState,
          //   builder: (context, state) {
          //
          //    if(state is ReceiptLoadedState){
          //      List<Payment> payments=state.payments;
          //     return ListView.builder(
          //      itemCount:payments.length,
          //             shrinkWrap: true,
          //             physics: const NeverScrollableScrollPhysics(),
          //             itemBuilder: (context, index) => Padding(
          //               padding: const EdgeInsets.only(bottom: 8),
          //               child: customRow(payments[index].treatmentName, payments[index].quantity.toString(), "third", payments[index].Amount.toString(),null),
          //             ),);
          //   }
          //   else return const Center(child: CircularProgressIndicator());
          //
          //
          //   }
          // ),
          const SizedBox(
            height: 10,
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
              custom(
                "Total Amt.",
                "-",
                "550.00",
                "INR",
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 17),
              custom(
                "Total Tax",
                "-",
                "68.00",
                "INR",
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 17),
              custom(
                "Total Cost",
                "-",
                "618.00",
                "INR",
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 17),
              custom(
                "Discount @10%",
                "-",
                "61.80",
                "INR",
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 7),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),

          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: custom(
                "Grand Total",
                "-",
                "556.20",
                "INR",
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff4646B5)),
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xff4646B5)),
              ),
            ),
          ]),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          //   child: customRow("Grand Total", "-", "556.20", "INR", const TextStyle(fontSize: 22,color: Color(0xff4646B5),fontWeight: FontWeight.w600)),
          // ),

          BlocBuilder<ReceiptBloc, ReceiptState>(
            bloc: bloc,
            buildWhen: (previous, current) => current is PaymentDoneState,
            builder: (context, state) {
              if (state is PaymentSuccessfullState) {
                return customRow("Balance Amt.", "-", "356", "INR", const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
              }
              return Container();
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),

          const SizedBox(
            height: 50,
          ),

          Column(
            children: [
              SizedBox(
                width: 250,
                child: GestureDetector(
                  onTap: () {
                    bloc.add(InitializePaymentEvent());
                  },
                  child: const CustomButton(
                    data: "Send payment link ",
                    Textsize: 16,
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
                child: GestureDetector(
                  onTap: () => _displayBottomSheet(context),
                  child: const CustomButton(
                    data: "Pay by cash",
                    height: 50,
                    Textsize: 16,
                    color: Color.fromARGB(255, 236, 235, 239),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget customRow(String first, String second, String third, String fourth, TextStyle? style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  first,
                  style: style,
                ))),
        Expanded(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  second,
                  style: style,
                ))),
        Expanded(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  third,
                  style: style,
                ))),
        Expanded(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  fourth,
                  style: style,
                )))
      ],
    );
  }

  Widget custom(String leadingText, String middleText, String trailingText, String unit, TextStyle leadingTextStyle, TextStyle trailingTextStyle) {
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

  Widget topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Invoice: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "263",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          DateFormat('d MMMM, yyyy').format(DateTime.now()).toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget RowTextfield(String Name, TextEditingController controller, String hint) {
    return Row(
      children: [
        Text(
          Name,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: CustomTextField(
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Field cannot be empty';
              }
              return null;
            },
            controller: controller,
            type: TextInputType.number,
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
