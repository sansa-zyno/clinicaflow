import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/custom_textfield.dart';

class TimeSlotTextField extends StatelessWidget {
  const TimeSlotTextField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        controller: controller,
        onTap: onTap,
        readOnly: true,
        hintText: hintText,
        height: 54);
  }
}
