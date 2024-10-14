import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:healtether_clinic_app/widgets/customButton.dart';

class PaymentRecordTile extends StatelessWidget {
  final String name;
  final String number;
  final String date;
  final String status;
  const PaymentRecordTile(
      {super.key,
      required this.name,
      required this.date,
      required this.number,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Container(
              width: 1,
              color: AppColors.blueColor,
            ),
            paymentStatusColumn()
          ],
        ));
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
        children: [
          const Text(AppText.paymentStatus),
          const SizedBox(
            height: 10,
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
            Textcolor:
                status == "Pending" ? AppColors.redColor : AppColors.grennColor,
          )
        ],
      ),
    );
  }
}
