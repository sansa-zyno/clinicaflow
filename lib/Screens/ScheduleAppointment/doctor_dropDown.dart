import 'package:flutter/material.dart';

class DoctorDropDown extends StatefulWidget {
  final Map? value;
  final List<Map<String, dynamic>>? doctors;
  final ValueChanged<Map?> onChanged;

  const DoctorDropDown(
      {super.key,
      required this.value,
      required this.doctors,
      required this.onChanged});

  @override
  State<DoctorDropDown> createState() => _DoctorDropDownState();
}

class _DoctorDropDownState extends State<DoctorDropDown> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> doctors = [
      {"firstName": "Attending", "lastName": "doctor"}
    ];
    if (widget.doctors != null && widget.doctors!.isNotEmpty) {
      for (Map<String, dynamic> doctor in widget.doctors!) {
        doctors.add(doctor);
      }
    }
    return Container(
      height: 52,
      color: const Color(0xffF5F5F5),
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
        child: DropdownButtonFormField<Map>(
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
          ),
          value: widget.value,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: doctors.map((Map value) {
            return DropdownMenuItem<Map>(
              value: value == doctors[0] ? null : value,
              child: Text(
                '${value['firstName']} ${value["lastName"]}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: value == doctors[0] ? Colors.grey : Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
