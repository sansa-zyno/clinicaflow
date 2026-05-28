import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:clinica_flow/features/appointment/service/appointment_service.dart';
import 'package:clinica_flow/core/utils/receipt_pdf.dart';
import 'package:clinica_flow/shared/widgets/customButton.dart';

import '../../../core/navigation/home_page_bottom_nav_cubit.dart';

class PaymentRecordTile extends StatelessWidget {
  final String name;
  final String number;
  final String date;
  final String status;
  final String invoiceId;
  const PaymentRecordTile({
    super.key,
    required this.name,
    required this.date,
    required this.number,
    required this.status,
    required this.invoiceId,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.96,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 6),
              status == "Pending" ? Container() : const SizedBox(width: 80),
              FutureBuilder(
                  future: AppointmentServices()
                      .getInvoiceById(invoiceId: invoiceId),
                  builder: (context, snapshot) {
                    return InkWell(
                      onTap: () {
                        if (snapshot.data != null) {
                          ReceiptPdf().generate(context, snapshot.data!);
                        }
                      },
                      child: Opacity(
                        opacity: snapshot.data == null ? 0.5 : 1,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Center(
                                    child: Image.asset(
                                  'assets/png/view_receipt.png',
                                  color: const Color(0xff413D56),
                                )),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'View Receipt',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(width: 6),
              status == "Pending"
                  ? InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF5F5F5),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/png/whatsapp.png',
                                  color: const Color(0xff413D56),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Send payment link',
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(width: 6),
              status == "Pending"
                  ? InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF5F5F5),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/png/paid_by_cash.png',
                                  color: const Color(0xff413D56),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Paid by Cash',
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  context.pop();
                  context.read<HomePageBottomNavCubit>().onPageChanged(1);
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF5F5F5),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/png/view_patient_details.png',
                            color: const Color(0xff413D56),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'View Patient details',
                        style: TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              status == "Pending" ? Container() : const SizedBox(width: 80),
            ],
          ),
        ],
      ),
      child: Container(
          height: 110,
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color.fromARGB(255, 236, 235, 239)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: detailsColumn()),
              /* Container(
                width: 1,
                color: AppColors.blueViolet,
              ),*/
              paymentStatusColumn()
            ],
          )),
    );
  }

  Widget detailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          number,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Text("Last visited : $date"),
        // Text(
        //   "Last visited : $date",
        // ),
      ],
    );
  }

  Widget paymentStatusColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Text(AppText.paymentStatus),
          /* const SizedBox(
            height: 10,
          ),*/
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
            Textcolor:
                status == "Pending" ? AppColors.redColor : AppColors.grennColor,
          )
        ],
      ),
    );
  }
}
