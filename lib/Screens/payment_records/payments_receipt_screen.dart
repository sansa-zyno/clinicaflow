import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';
import 'package:healtether_clinic_app/business_logic/cubits/appointment_cubit/appointment_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/utils/snackbar.dart';

class Item {
  TextEditingController treatmentController;
  TextEditingController quantityController;
  TextEditingController amountPerUnitController;
  TextEditingController discountRateController;
  TextEditingController taxRateController;

  Item({
    required this.treatmentController,
    required this.quantityController,
    required this.amountPerUnitController,
    required this.discountRateController,
    required this.taxRateController,
  });
}

class PaymentsReceiptScreen extends StatefulWidget {
  final String invoiceId;
  const PaymentsReceiptScreen({super.key, required this.invoiceId});

  @override
  State<PaymentsReceiptScreen> createState() => _PaymentsReceiptScreenState();
}

class _PaymentsReceiptScreenState extends State<PaymentsReceiptScreen> {
  List<Item> items = [
    Item(
      treatmentController: TextEditingController(text: 'Consultation'),
      quantityController: TextEditingController(text: ''),
      amountPerUnitController: TextEditingController(text: ''),
      discountRateController: TextEditingController(text: ''),
      taxRateController: TextEditingController(text: ''),
    ),
  ];

  void addItem() {
    setState(() {
      items.add(Item(
        treatmentController: TextEditingController(text: 'Consultation'),
        quantityController: TextEditingController(text: ''),
        amountPerUnitController: TextEditingController(text: ''),
        discountRateController: TextEditingController(text: ''),
        taxRateController: TextEditingController(text: ''),
      ));
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      /* for (int i = 0; i < items.length; i++) {
        items[i].treatmentController.text = 'Consultation';
      }*/
    });
  }

  bool get isItemsListNotEmpty => items.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(AppText.paymentsReceipt),
      ),
      body: BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state.state == AppointmentStates.invoiceAdded) {
            context.read<AppointmentCubit>().getInvoiceById(invoiceId: widget.invoiceId);
            if (state.state != AppointmentStates.invoiceFetched) {
              context.pushNamed(AppRoutes.paymentReceiptInvoice.name);
            }
          } else if (state.state == AppointmentStates.addingInvoiceFailed) {
            showSnackbar(state.error!, context);
          }
          if (state.state == AppointmentStates.invoiceFetched && state.invoiceDetails != null) {
            items = state.invoiceDetails!.treatments!
                .map((item) => Item(
                      treatmentController: TextEditingController(text: item.treatment),
                      quantityController: TextEditingController(text: () {
                        if ((item.quantity ?? 1) < 1) {
                          //min
                          return "1";
                        } else {
                          return item.quantity?.toString() ?? "1";
                        }
                      }()),
                      amountPerUnitController: TextEditingController(text: item.amount.toString()),
                      discountRateController: TextEditingController(text: () {
                        if ((item.discRate ?? 1) < 1) {
                          //min
                          return "1";
                        } else if ((item.discRate ?? 1) <= 100) {
                          return item.discRate?.toString() ?? "1";
                        } else {
                          //max
                          return "100";
                        }
                      }()),
                      taxRateController: TextEditingController(text: ''),
                    ))
                .toList();
          }
        },
        child: BlocBuilder<AppointmentCubit, AppointmentState>(builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppText.addItems,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black1Color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppText.treatment,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                height: 52,
                                controller: item.treatmentController,
                                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                                hintText: '',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Quantity',
                                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: screenWidth * 0.2,
                                        child: CustomTextField(
                                          keyBoardType: TextInputType.number,
                                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                                          height: 52,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          controller: item.quantityController,
                                          hintText: '',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Amt/unit',
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomTextField(
                                            keyBoardType: TextInputType.number,
                                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                            height: 52,
                                            controller: item.amountPerUnitController,
                                            hintText: '',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Dst. rate',
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomTextField(
                                            keyBoardType: TextInputType.number,
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                                            height: 52,
                                            controller: item.discountRateController,
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^[1-9]\$|^[1-9][0-9]\$|^(100)\$'))],
                                            hintText: '',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Tax rate',
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomTextField(
                                            keyBoardType: TextInputType.number,
                                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                                            height: 52,
                                            controller: item.taxRateController,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            hintText: '',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => deleteItem(index),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.minimize_outlined, color: Colors.blueAccent),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                "Delete item",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 2,
                                            width: 110,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: addItem,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.add, color: Colors.blueAccent),
                                            Text(
                                              "Add another item",
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 2,
                                            width: 150,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 170),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: screenWidth * 0.1,
                child: state.state == AppointmentStates.addingInvoice
                    ? SizedBox(
                        width: screenWidth * 0.8,
                        height: 60,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Container(
                        height: 60,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: isItemsListNotEmpty ? AppColors.greenColor : AppColors.grey1Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: isItemsListNotEmpty
                                ? () {
                                    try {
                                      List<Map<String, dynamic>> treatments = items
                                          .map((item) => {
                                                "treatment": item.treatmentController.text,
                                                "quantity": () {
                                                  if ((int.tryParse(item.quantityController.text) ?? -1) > 0) {
                                                    return int.parse(item.quantityController.text);
                                                  } else {
                                                    throw 'Quantity must be a valid integer greater than 0';
                                                  }
                                                }(),
                                                "amount": () {
                                                  if (double.tryParse(item.amountPerUnitController.text) != null) {
                                                    return double.parse(item.amountPerUnitController.text);
                                                  } else {
                                                    throw 'Amount must be a valid decimal number';
                                                  }
                                                }(),
                                                "discRate": () {
                                                  if (int.tryParse(item.discountRateController.text) != null) {
                                                    return int.parse(item.discountRateController.text);
                                                  } else {
                                                    throw 'Discount rate must be a valid integer between 1 and 100';
                                                  }
                                                }()
                                              })
                                          .toList();
                                      context.read<AppointmentCubit>().addInvoice(
                                          invoiceId: widget.invoiceId,
                                          treatments: treatments,
                                          discount: () {
                                            if ((state.invoiceDetails?.discount ?? 1) < 1) {
                                              //min
                                              return 1;
                                            } else if ((state.invoiceDetails?.discount ?? 1) <= 100) {
                                              return state.invoiceDetails?.discount ?? 1;
                                            } else {
                                              //max
                                              return 100;
                                            }
                                          }());
                                    } catch (e) {
                                      showSnackbar(e.toString(), context);
                                    }
                                  }
                                : null,
                            child: const Text(
                              AppText.save,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
