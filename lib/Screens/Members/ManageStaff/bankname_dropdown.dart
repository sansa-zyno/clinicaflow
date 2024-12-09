import 'package:flutter/material.dart';

class BankNameDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const BankNameDropDown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: const Color(0xffF5F5F5),
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
          ),
          value: value,
          items: <String>['Bank name', 'Indian Bank', 'SBI Bank','HDFC Bank','PNB Bank','Others']
              .map((String value) {
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
    );
  }
}
