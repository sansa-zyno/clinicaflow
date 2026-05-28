import 'package:flutter/material.dart';

class IdProofDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const IdProofDropDown(
      {super.key, required this.value, required this.onChanged});

  //['Select ID proof','Aadhar', 'PAN card', 'FamilyID', 'Others']

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
              'Select ID proof',
              'Passport',
              'NIN',
              'BVN',
              'Voter\'s Card',
              'Driver\'s Liscence',
              'Others'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value == 'Select ID proof' ? null : value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        value == 'Select ID proof' ? Colors.grey : Colors.black,
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
