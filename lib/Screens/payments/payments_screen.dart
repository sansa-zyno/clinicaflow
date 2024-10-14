import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/widgets/payments_item.dart';
import 'package:healtether_clinic_app/business_logic/blocs/payment_bloc/payments_bloc.dart';
import 'package:healtether_clinic_app/Screens/payments/payment_receipt/payments_receipt_screen.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_model.dart/paymnets_model.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  bool showCheckBox = false;
  List<PaymentModel> itemsController = [
    PaymentModel(
        treatmentController: TextEditingController(),
        amountController: TextEditingController(),
        quantityController: TextEditingController(),
        rateController: TextEditingController(),
        formKey: GlobalKey<FormState>())
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PaymentsBloc bloc = BlocProvider.of<PaymentsBloc>(context, listen: false);
    bloc.add(InitialPaymentLoadEvent(Items: itemsController));

    return BlocListener<PaymentsBloc, PaymentsState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is PaymentScreenActionState,
      listener: (context, state) {
        // TODO: implement listener

        if (state is PaymnetScreenVerifiedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentsReceipt(),
              ));
          bloc.add(InitialPaymentLoadEvent(Items: itemsController));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Payments Reciept",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                "Add Items",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<PaymentsBloc, PaymentsState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      current is! PaymentScreenActionState,
                  builder: (context, state) {
                    if (state is PaymentManageState) {
                      itemsController = state.items;
                    } else {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemsController.length,
                      itemBuilder: (context, index) {
                        return PaymentItem(
                          index: index,
                          paymentDetails: itemsController[index],
                          showCheckBox: showCheckBox,
                        );
                      },
                    );
                  }),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      bloc.add(ItemAddedEvent(Items: itemsController));
                    },
                    child: const Text(
                      "+ Add Item",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  bloc.add(VerifyPaymentsItemsEvent(Items: itemsController));
                },
                child: CustomButton(
                  data: "Save",
                  height: 50,
                  color: const Color(0xff03BF9C),
                  Textcolor: Colors.white,
                  Textsize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
