import 'package:flutter/material.dart';

class GenderDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GenderDropDown({super.key, required this.value, required this.onChanged});

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
          items: <String>['Gender', 'Male', 'Female', 'Others']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value == 'Gender' ? null : value,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0,top: 4,bottom: 4),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: value == 'Gender' ? Colors.grey : Colors.black,
                  ),
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


class GenderContainer extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  GenderContainer({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: const Color(0xffF5F5F5),
      width: 150, // Set a fixed width or adjust as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10,top: 7),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
          ),
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: <String>['Gender', 'Male', 'Female', 'Others']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value == 'Gender' ? null : value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: value == 'Gender' ? Colors.grey : Colors.black,
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
