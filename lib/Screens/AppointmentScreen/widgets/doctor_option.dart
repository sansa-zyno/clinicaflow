import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorOption extends StatefulWidget {
  final String? value;
  final List<Map<String, String>> items;
  final Function(String?) onChanged;
  final String hintText;

  const DoctorOption({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  DoctorOptionState createState() => DoctorOptionState();
}

class DoctorOptionState extends State<DoctorOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color(0xffF5F5F5),
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 10, left: 10, right: 30),
        child: DropdownButtonFormField<Map<String, String>>(
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            isDense: true,
          ),
          value: widget.value != null
              ? widget.items.firstWhere(
                  (doctor) =>
                      '${doctor['firstName']} ${doctor['lastName']}' ==
                      widget.value,
                  orElse: () => widget.items.firstWhere((doctor) =>
                      doctor['firstName'] ==
                      widget.hintText), // Use the hintText as default value
                )
              : null,
          items: widget.items.map((Map<String, String> doctor) {
            return DropdownMenuItem<Map<String, String>>(
              value: doctor,
              child: Text(
                'Dr. ${doctor['firstName']} ${doctor['lastName']} (${doctor['specialization']})', // Displaying name with "Dr." and specialization
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.value != null &&
                          '${doctor['firstName']} ${doctor['lastName']}' ==
                              widget.value
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
          onChanged: (Map<String, String>? newValue) {
            if (newValue != null) {
              widget.onChanged(
                  '${newValue['firstName']} ${newValue['lastName']}');
            }
          },
        ),
      ),
    );
  }
}
