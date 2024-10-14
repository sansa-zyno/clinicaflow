import 'package:flutter/material.dart';

class TitleDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const TitleDropDown({super.key, required this.value, required this.onChanged});

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
          items: <String>['Title', 'Doctor', 'Patient', 'Others']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value == 'Title' ? null : value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: value == 'Title' ? Colors.grey : Colors.black,
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
