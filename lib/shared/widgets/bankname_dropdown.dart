import 'package:flutter/material.dart';

class BankNameDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const BankNameDropDown(
      {super.key, required this.value, required this.onChanged});

  //['Bank name', 'Indian Bank', 'SBI Bank','HDFC Bank','PNB Bank','Others']

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF7F7F7)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            value: value,
            items: <String>[
              'Bank name',
              'GT Bank',
              'Union Bank',
              'Wema Bank',
              'Zenith Bank',
              'First Bank',
              'Fcmb Bank',
              'Others'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value == 'Bank name' ? null : value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: value == 'Bank name' ? Colors.grey : Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
