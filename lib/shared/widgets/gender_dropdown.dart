import 'package:flutter/material.dart';

class GenderDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GenderDropDown(
      {super.key, required this.value, required this.onChanged});

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
              contentPadding: EdgeInsets.zero,
            ),
            value: value,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF7F7F7)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
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
